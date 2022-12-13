package com.landray.kmss.util;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.BitSet;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
 
/**
 * @peng 识别文件编码格式(不保证100%准确)
 *
 */
public class CharsetUtil {
	private static Logger logger = LoggerFactory.getLogger(CharsetUtil.class);
 
	private static int BYTE_SIZE = 8;
    public static String CODE_UTF8 = "UTF-8";
    public static String CODE_UTF8_BOM = "UTF-8_BOM";
    public static String CODE_GBK = "GBK";
 
    /**
     * 通过文件全名称获取编码集名称
     *
     * @param fullFileName
     * @param ignoreBom
     * @return
     * @throws Exception
     */
    public static String getEncode(File file, boolean ignoreBom) throws Exception {
    	logger.debug("fullFileName ; {}", file.getCanonicalPath());
    	BufferedInputStream bis = null;
    	String enCode = "";
    	try {
    		bis = new BufferedInputStream(new FileInputStream(file));
    		enCode = getEncode(bis, ignoreBom);
    	} catch (Exception e) {
    		logger.error(e.getMessage(), e);
    		throw new Exception(e);
		} finally {
			if (bis != null) {
				IOUtils.closeQuietly(bis);
			}
		}
        return enCode;
    }
 
    /**
     * 通过文件缓存流获取编码集名称，文件流必须为未曾读过
     * @param bis
     * @param ignoreBom 是否忽略utf-8 bom
     * @return
     * @throws Exception
     */
    public static String getEncode(BufferedInputStream bis, boolean ignoreBom) throws Exception {
        bis.mark(0);
 
        String encodeType = "未识别";
        byte[] head = new byte[3];
        while(bis.read(head) != -1){//只需要bis.read(head)读一次，此处为规避sonar扫描报警告
        	break;
        }
        if (head[0] == -1 && head[1] == -2) {
            encodeType = "UTF-16";
        } else if (head[0] == -2 && head[1] == -1) {
            encodeType = "Unicode";
        } else if (head[0] == -17 && head[1] == -69 && head[2] == -65) { //带BOM
            if (ignoreBom) {
                encodeType = CODE_UTF8;
            } else {
                encodeType = CODE_UTF8_BOM;
            }
        } else if ("Unicode".equals(encodeType)) {
            encodeType = "UTF-16";
        } else if (isUTF8(bis)) {
            encodeType = CODE_UTF8;
        } else {
            encodeType = CODE_GBK;
        }
        logger.info("result encode type : " + encodeType);
        return encodeType;
    }
    
    /**
     * 
     * @param bytes
     * @param ignoreBom
     * @return
     * @throws Exception
     */
    public static String getEncode(byte[] bytes, boolean ignoreBom) throws Exception {
    	BufferedInputStream bis = null;
    	String enCode = "";
    	try {
    		bis = new BufferedInputStream(new ByteArrayInputStream(bytes));
    		enCode = getEncode(bis, ignoreBom);
    	} catch (Exception e) {
    		logger.error(e.getMessage(), e);
    		throw new Exception(e);
		} finally {
			if (bis != null) {
				IOUtils.closeQuietly(bis);
			}
		}
        return enCode;
    }
 
    /**
     * 是否是无BOM的UTF8格式，不判断常规场景，只区分无BOM UTF8和GBK
     *
     * @param bis
     * @return
     */
    private static boolean isUTF8( BufferedInputStream bis) throws Exception {
        bis.reset();
 
        //读取第一个字节
        int code = bis.read();
        do {
            BitSet bitSet = convert2BitSet(code);
            //判断是否为单字节
            if (bitSet.get(0)) {//多字节时，再读取N个字节
                if (!checkMultiByte(bis, bitSet)) {//未检测通过,直接返回
                    return false;
                }
            } else {
                //单字节时什么都不用做，再次读取字节
            }
            code = bis.read();
        } while (code != -1);
        return true;
    }
 
    /**
     * 检测多字节，判断是否为utf8，已经读取了一个字节
     *
     * @param bis
     * @param bitSet
     * @return
     */
    private static boolean checkMultiByte(BufferedInputStream bis, BitSet bitSet) throws Exception {
        int count = getCountOfSequential(bitSet);
        byte[] bytes = new byte[count - 1];//已经读取了一个字节，不能再读取
        while(bis.read(bytes) != -1){//只需要bis.read(bytes)读一次，此处为规避sonar扫描报警告
        	break;
        }
        for (byte b : bytes) {
            if (!checkUtf8Byte(b)) {
                return false;
            }
        }
        return true;
    }
 
    /**
     * 检测单字节，判断是否为utf8
     *
     * @param b
     * @return
     */
    private static boolean checkUtf8Byte(byte b) throws Exception {
        BitSet bitSet = convert2BitSet(b);
        return bitSet.get(0) && !bitSet.get(1);
    }
 
    /**
     * 检测bitSet中从开始有多少个连续的1
     *
     * @param bitSet
     * @return
     */
    private static int getCountOfSequential( BitSet bitSet) {
        int count = 0;
        for (int i = 0; i < BYTE_SIZE; i++) {
            if (bitSet.get(i)) {
                count++;
            } else {
                break;
            }
        }
        return count;
    }
 
 
    /**
     * 将整形转为BitSet
     *
     * @param code
     * @return
     */
    private static BitSet convert2BitSet(int code) {
        BitSet bitSet = new BitSet(BYTE_SIZE);
 
        for (int i = 0; i < BYTE_SIZE; i++) {
            int tmp3 = code >> (BYTE_SIZE - i - 1);
            int tmp2 = 0x1 & tmp3;
            if (tmp2 == 1) {
                bitSet.set(i);
            }
        }
        return bitSet;
    }
 
    /**
     * 将一指定编码的文件转换为另一编码的文件
     *
     * @param oldFullFileName
     * @param oldCharsetName
     * @param newFullFileName
     * @param newCharsetName
     */
    public static void convert(InputStream srcStream, String srcCharsetName, OutputStream destStream
    		, String destCharsetName) throws Exception {
    	logger.info("The srcCharsetName is : {}",  srcCharsetName);
    	logger.info("The destCharsetName is : {}", destCharsetName);
 
        StringBuffer content = new StringBuffer();
 
        BufferedReader bin = new BufferedReader(new InputStreamReader(srcStream, srcCharsetName));
        String line;
        while ((line = bin.readLine()) != null) {
            content.append(line);
            content.append(System.getProperty("line.separator"));
        }
        Writer out = new OutputStreamWriter(destStream, destCharsetName);
        out.write(content.toString());
        out.close();
    }
 
}
