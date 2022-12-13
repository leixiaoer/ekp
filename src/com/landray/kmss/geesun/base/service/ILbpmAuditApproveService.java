package com.landray.kmss.geesun.base.service;

public interface ILbpmAuditApproveService {

	/**
	 * 自动审批通过
	 * 
	 * @param fdProcessId
	 * @param auditNote
	 * @return
	 * @throws Exception
	 */
	public void updateBatchApprove(String fdProcessId, final String auditNote) throws Exception;
	
}
