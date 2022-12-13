package com.landray.kmss.geesun.org.init;

import com.landray.kmss.common.actions.RequestContext;
import com.landray.kmss.sys.metadata.interfaces.IExtendDataEvent;
import com.landray.kmss.sys.metadata.interfaces.IExtendDataModel;
import com.landray.kmss.sys.metadata.interfaces.ISysMetadataParser;

public class GeesunTestListenerFormEvent implements IExtendDataEvent {

	@Override
	public void onAdd(IExtendDataModel arg0, ISysMetadataParser arg1) throws Exception {
		// TODO Auto-generated method stub
		String fdText1 = (String) arg1.getFieldValue(arg0, "fd_3af5233b7c9974", true);
		System.out.println("文本1的值为：" + fdText1);
	}

	@Override
	public void onDelete(IExtendDataModel arg0, ISysMetadataParser arg1) throws Exception {
		// TODO Auto-generated method stub
		Double fdText2 = (Double) arg1.getFieldValue(arg0, "fd_3af52ae5f3ea20", true);
		System.out.println("数字的值为：" + fdText2);
	}

	@Override
	public void onInit(RequestContext arg0, IExtendDataModel arg1, ISysMetadataParser arg2) throws Exception {
		arg2.setFieldValue(arg1, "fd_3af5233b7c9974", "1111");
		
	}

	@Override
	public void onUpdate(IExtendDataModel arg0, ISysMetadataParser arg1) throws Exception {
		// TODO Auto-generated method stub

	}

}
