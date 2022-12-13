package com.landray.kmss.geesun.annual.util;

import java.util.ArrayList;
import java.util.List;

import com.landray.kmss.common.forms.BaseForm;

public class GeesunImportMessage extends BaseForm{

	 public static final int MESSAGE_FAIL = 0;
	  public static final int MESSAGE_WARN = 1;
	  public static final int MESSAGE_SUCCESS = 2;
	  protected String message = null;

	  protected List<String> moreMessages = new ArrayList();
	  protected int messageType;

	  public String getMessage()
	  {
	    return this.message;
	  }

	  public void setMessage(String message) {
	    this.message = message;
	  }

	  public List<String> getMoreMessages() {
	    return this.moreMessages;
	  }

	  public void setMoreMessages(List<String> moreMessages) {
	    this.moreMessages = moreMessages;
	  }

	  public int getMessageType() {
	    return this.messageType;
	  }

	  public void setMessageType(int messageType) {
	    this.messageType = messageType;
	  }

	  public void addFailMsg(String message)
	  {
	    this.messageType = 0;
	    this.message = message;
	  }

	  public void addWarnMsg(String message)
	  {
	    this.messageType = 1;
	    this.message = message;
	  }

	  public void addSuccessMsg(String message)
	  {
	    this.messageType = 2;
	    this.message = message;
	  }

	  public void addMoreMsg(String message)
	  {
	      this.moreMessages.add(message);
	    
	  }
	
}
