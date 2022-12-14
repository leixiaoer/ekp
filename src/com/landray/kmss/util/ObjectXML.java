package com.landray.kmss.util;

import java.beans.DefaultPersistenceDelegate;
import java.beans.Encoder;
import java.beans.Expression;
import java.beans.PersistenceDelegate;
import java.beans.XMLDecoder;
import java.beans.XMLEncoder;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.landray.kmss.sys.profile.model.SysCommonSensitiveConfig;

public class ObjectXML {
    private static final Log logger = LogFactory.getLog(ObjectXML.class);
    public static void objectXmlEncoder(Object obj, String fileName)
            throws FileNotFoundException, IOException, Exception {
        String path = fileName.substring(0, fileName.lastIndexOf('/'));
        if (path.indexOf('/') != -1) {
            File pFile = new File(path);
            if (!pFile.exists()) {
                pFile.mkdirs();
            }
        }
        File fo = new File(fileName);
        FileOutputStream fos = new FileOutputStream(fo);
        XMLEncoder encoder = new XMLEncoder(fos);
        encoder.writeObject(obj);
        encoder.flush();
        encoder.close();
        fos.close();
    }
    
    private static final PersistenceDelegate bigDecimalPersistenceDelegate = new DefaultPersistenceDelegate() {
        @Override
        protected Expression instantiate(Object oldInstance,
                Encoder out) {
            BigDecimal bd = (BigDecimal) oldInstance;
            return new Expression(oldInstance, oldInstance
                    .getClass(), "new", new Object[] { bd
                    .toString() });
        }

        @Override
        protected boolean mutatesTo(Object oldInstance,
                Object newInstance) {
            return oldInstance.equals(newInstance);
        }
    };

    public static String objectXmlEncoder(Object obj)
            throws FileNotFoundException, IOException, Exception {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        XMLEncoder encoder = new XMLEncoder(baos);
        encoder.setPersistenceDelegate(BigDecimal.class,
                bigDecimalPersistenceDelegate);
        encoder.writeObject(obj);
        encoder.flush();
        encoder.close();
        String rtnVal = new String(baos.toByteArray(), "UTF-8");
        baos.close();
        return rtnVal;
    }

    /**
     * ?????????objSource?????????XML????????????????????????????????????,????????????????????????List??????
     * 
     * @param objSource
     *            ????????????????????????????????????
     * @return ???XML????????????????????????????????????List??????(??????????????????????????????????????????????????????)
     * @throws FileNotFoundException
     *             ????????????????????????????????????
     * @throws IOException
     *             ??????????????????
     * @throws Exception
     *             ???????????????????????????
     */
    public static List objectXmlDecoder(String objSource)
            throws FileNotFoundException, IOException, Exception {
        File fin = new File(objSource);
        
        FileInputStream fileInputStream = null;
        try{
            fileInputStream = new FileInputStream(fin);
            return objectXmlDecoder(fileInputStream);
        }finally{
            if(fileInputStream!=null){
                fileInputStream.close();
            }
        }
    }

    public static List objectXMLDecoderByString(String ins) throws Exception {
        String safeIns = ins.replaceAll("[\\x00-\\x08\\x0b-\\x0c\\x0e-\\x1f]", "");
        ByteArrayInputStream byteArrayInputStream = null;
        try{
            byteArrayInputStream = new ByteArrayInputStream(safeIns.getBytes("UTF-8"));
            return objectXmlDecoder(byteArrayInputStream);
        }finally{
            if(byteArrayInputStream!=null){
                byteArrayInputStream.close();
            }
        }
    }

    
    public static List objectXmlDecoder(InputStream ins) throws IOException,
            Exception {
        List objList = new ArrayList();
        ByteArrayOutputStream os = null;
        try{
            int len=-1;
            os = new  ByteArrayOutputStream();//?????????close
            byte[] buffer = new byte[1024];
            while((len=ins.read(buffer, 0,1024))!=-1){
                os.write(buffer, 0, len);
            }
            String xmlStr = os.toString("UTF-8");
            if(logger.isDebugEnabled()){
                logger.debug("ready to security check: " + xmlStr);
            }
            os = null;
            deserializationSecurityCheck(new ByteArrayInputStream(xmlStr.getBytes("UTF-8")));
            //List<String> blackList = getBlackList();
            ByteArrayInputStream bis = new ByteArrayInputStream(xmlStr.getBytes("UTF-8"));
            xmlStr = null;// GC
            XMLDecoder decoder = new XMLDecoder(bis);
            Object obj = null;
            try {
                while ((obj = decoder.readObject()) != null) {
                    objList.add(obj);
                }
                // readObject???????????? ArrayIndexOutOfBoundsException???????????????
            } catch (ArrayIndexOutOfBoundsException e) {
            } finally {
                decoder.close();
            }
        }catch(Exception e){
            logger.error(e.getMessage(),e);
            throw new IOException(e);
        }
        return objList;
    }
    
    /**
     * ??????xml???????????????????????????????????????????????????
     * @return
     */
    private static Set<String> getWhiteSet(){
        Set<String> set = new HashSet<>();
        //java.lang.ProcessBuilder???????????????????????????
        SysCommonSensitiveConfig config = SysCommonSensitiveConfig.newInstance();
        String wl = config.getFdXmlDeserializeWhitelist();
        if(StringUtil.isNotNull(wl)){
            String[] split = wl.split("\\s*;\\s*");
            for(String s:split){
                set.add(s.trim());
            }
        }
        return set;
    }
    /**
     * xml????????????????????????????????????????????????
     * @param is
     * @throws Exception ?????????????????????????????????
     */
    private static void  deserializationSecurityCheck(InputStream is) throws Exception{
        DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();
        documentBuilderFactory.setIgnoringElementContentWhitespace(true);
        DocumentBuilder documentBuilder = documentBuilderFactory.newDocumentBuilder();
        Document document = documentBuilder.parse(is);
        Set<String> classNameSet = new HashSet<>();
        // ?????? <object class="java.lang.ProcessBuilder">?????????????????????
        NodeList elementsByTagName = document.getElementsByTagName("object");
        fillClass(elementsByTagName,classNameSet);
        // ?????? <void class="java.lang.ProcessBuilder">?????????????????????
        NodeList voidTags = document.getElementsByTagName("void");
        fillClass(voidTags,classNameSet);
        if(!classNameSet.isEmpty()){
            Set<String> whiteSet = getWhiteSet();
            for(String className:classNameSet){
                //EKP?????????java????????????????????????????????????????????????????????????
                if(!whiteSet.contains(className)){
                    //??????????????????????????????????????????????????????????????????
                    Iterator<String> iterator = whiteSet.iterator();
                    boolean isOk = false;
                    while(iterator.hasNext()){
                        String next = iterator.next();
                        //???*?????????????????????????????????equals
                        if(next.indexOf('*')>-1){
                            Pattern compile = Pattern.compile(next);
                            Matcher matcher = compile.matcher(className);
                            boolean matches = matcher.matches();
                            if(matches){
                                isOk = true;
                                break;// ????????????????????????OK
                            }
                        }else{
                            if(next.equals(className)){
                                isOk = true;
                                break;// ????????????????????????OK
                            }
                        }
                    }
                    if(!isOk){
                        throw new IllegalArgumentException(className+"?????????????????????????????????????????????????????????????????????????????????????????????->????????????????????????->???????????????????????????");
                    }
                }else{
                  //???????????????bu????????????????????????
                }
                
            }
        }
    }
    
    private static void fillClass(NodeList tags,Set<String> classNameSet){
        if(tags!=null && tags.getLength()>0){
            for(int i=0;i<tags.getLength();i++){
                Node item = tags.item(i);
                NamedNodeMap attributes = item.getAttributes();
                if(attributes!=null && attributes.getLength()>0){
                    Node namedItem = attributes.getNamedItem("class");
                    if(namedItem!=null){
                        String nodeValue = namedItem.getNodeValue();
                        if(StringUtil.isNotNull(nodeValue)){
                            classNameSet.add(nodeValue.trim());
                        }
                    }
                }
            }
        }
    }
}
