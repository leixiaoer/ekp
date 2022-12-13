<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
if(data.length>0){
{$<div style="background-color:#fff; width:700px;margin:5px auto;min-height:150px"> <div class="streamBox">$}
    {$<div class="imeeting_history_box">$}
		var tmpDate="";
		for(var i=0; i < data.length; i++){
			var date=data[i].date;
		if(!tmpDate || tmpDate.substring(0,10)!=date.substring(0,10) ){
			{$
              <div class="div_dateBar">
                <div class="dateBar">
                 <span class="month" >{%date.substring(0,10)%}</span>
                </div>
              </div>
             $}
        }
	
		var fdApplyModelname = data[i].fdApplyModelname;
		if(fdApplyModelname=='com.landray.kmss.km.review.model.KmReviewMain'){
		  {$
		  	<div class="head">
		  		<span class="time">{%date.substring(11)%}</span>
                <span class="line"></span>
          $}
                if(data[i].fdOperType == '变更'){
                	{$<span class="title icon_change">{%data[i].fdOperType%}</span>$}
                }
				if(data[i].fdOperType == '调拨'){
                	{$<span class="title icon_divert">{%data[i].fdOperType%}</span>$}
                }
                if(data[i].fdOperType == '领用'){
                	{$<span class="title icon_get">{%data[i].fdOperType%}</span>$}
                }
		  {$
		  	</div>
		  $}
		}
		if(fdApplyModelname=='com.landray.kmss.km.asset.model.KmAssetApplyDivert'){
          {$
            <div class="head">
                <span class="time">{%date.substring(11)%}</span>
                <span class="line"></span>
				<span class="title icon_divert">{%data[i].fdOperType%}</span>
			</div>
		   $}
		 }
		if(fdApplyModelname=='com.landray.kmss.km.asset.model.KmAssetApplyBuy'){
          {$
            <div class="head">
                <span class="time">{%date.substring(11)%}</span>
                <span class="line"></span>
				<span class="title icon_buy">{%data[i].fdOperType%}</span>
			</div>
		   $}
		 }
		 if(fdApplyModelname=='com.landray.kmss.km.asset.model.KmAssetApplyChange'){
          {$
            <div class="head">
                <span class="time"  >{%date.substring(11)%}</span>
                <span class="line"></span>
				<span class="title icon_change">{%data[i].fdOperType%}</span>
			</div>
		   $}
		 }
		  if(fdApplyModelname=='com.landray.kmss.km.asset.model.KmAssetApplyDeal'){
          {$
            <div class="head">
                <span class="time"  >{%date.substring(11)%}</span>
                <span class="line"></span>
				<span class="title icon_deal">{%data[i].fdOperType%}</span>
			</div>
		   $}
		 }
		   if(fdApplyModelname=='com.landray.kmss.km.asset.model.KmAssetApplyGet'){
          {$
            <div class="head">
                <span class="time"  >{%date.substring(11)%}</span>
                <span class="line"></span>
				<span class="title icon_get">{%data[i].fdOperType%}</span>
			</div>
		   $}
		 }
		  if(fdApplyModelname=='com.landray.kmss.km.asset.model.KmAssetApplyIn'){
          {$
            <div class="head">
                <span class="time"  >{%date.substring(11)%}</span>
                <span class="line"></span>
				<span class="title icon_in">{%data[i].fdOperType%}</span>
			</div>
		   $}
		 }
		  if(fdApplyModelname=='com.landray.kmss.km.asset.model.KmAssetApplyRent'){
          {$
            <div class="head">
                <span class="time"  >{%date.substring(11)%}</span>
                <span class="line"></span>
				<span class="title icon_rent">{%data[i].fdOperType%}</span>
			</div>
		   $}
		 }
		   if(fdApplyModelname=='com.landray.kmss.km.asset.model.KmAssetApplyRepair'){
          {$
            <div class="head">
                <span class="time"  >{%date.substring(11)%}</span>
                <span class="line"></span>
				<span class="title icon_repair">{%data[i].fdOperType%}</span>
			</div>
		   $}
		 }
		    if(fdApplyModelname=='com.landray.kmss.km.asset.model.KmAssetApplyReturn'){
          {$
            <div class="head">
                <span class="time"  >{%date.substring(11)%}</span>
                <span class="line"></span>
				<span class="title icon_return">{%data[i].fdOperType%}</span>
			</div>
		   $}
		 }
		   if(fdApplyModelname=='com.landray.kmss.km.asset.model.KmAssetApplyStock'){
          {$
            <div class="head">
                <span class="time"  >{%date.substring(11)%}</span>
                <span class="line"></span>
				<span class="title icon_stock">{%data[i].fdOperType%}</span>
			</div>
		   $}
		 }
		  if(fdApplyModelname=='com.landray.kmss.km.asset.model.KmAssetApplyInventory'){
          {$
            <div class="head">
                <span class="time"  >{%date.substring(11)%}</span>
                <span class="line"></span>
				<span class="title icon_stock">{%data[i].fdOperType%}</span>
			</div>
		   $}
		 }
		 if(fdApplyModelname=='com.landray.kmss.km.asset.model.KmAssetCard'){
          {$
            <div class="head">
                <span class="time"  >{%date.substring(11)%}</span>
                <span class="line"></span>
				<span class="title icon_stock">{%data[i].fdOperType%}</span>
			</div>
		   $}
		 }
		 
		   {$	
            <div class="stream_contentWrap">
                <i class="arrow M_arr"></i><i class="arrow C_arr"></i>
                <div class="stream_contentHeadL">
                    <div class="stream_contentHeadR">
                        <div class="stream_contentHeadC"></div>
                    </div>
                </div>
                <div class="stream_content">
                    <div class="s_content_title">
                        <img src="{%env.fn.formatUrl(data[i].optPersonHeadUrl)%}" height="40px" width="40px"/>
                        <ul class="title_txt">
                            <li><span><bean:message bundle="km-asset" key="kmAssetCardLife.fdApplyPerson" />：{%data[i].optPersonName%}</span></li>
                        </ul>
                    </div>
                    $}
                if(fdApplyModelname=='com.landray.kmss.km.review.model.KmReviewMain'){
                  {$
	                  <div class="txt">
	                        <p>{%env.fn.formatText(data[i].fdOperContent)%}</p>
	                        <p class="txtBold"><bean:message bundle="km-asset" key="kmAssetCardLife.fdApplyModelid" />：
								<a target="_blank" onclick="Com_OpenNewWindow(this)" data-href='<c:url value="/km/review/km_review_main/kmReviewMain.do?method=view&fdId={%data[i].fdApplyModelid%}"/>'>
									{%data[i].fdApplyModelNo%}
								</a>
	                        </p>
	                    </div>
			      $}	
                }
	            if(fdApplyModelname=='com.landray.kmss.km.asset.model.KmAssetApplyDivert'){
	             {$
	                  <div class="txt">
	                        <p>{%env.fn.formatText(data[i].fdOperContent)%}</p>
	                        <p class="txtBold"><bean:message bundle="km-asset" key="kmAssetCardLife.fdApplyModelid" />：
								<a target="_blank" onclick="Com_OpenNewWindow(this)" data-href='<c:url value="/km/asset/km_asset_apply_divert/kmAssetApplyDivert.do?method=view&fdId={%data[i].fdApplyModelid%}"/>'>
									{%data[i].fdApplyModelNo%}
								</a>
	                        </p>
	                    </div>
			      $}
			     }
			     if(fdApplyModelname=='com.landray.kmss.km.asset.model.KmAssetApplyBuy'){
	             {$
	                  <div class="txt">
	                        <p>{%env.fn.formatText(data[i].fdOperContent)%}</p>
	                        <p class="txtBold"><bean:message bundle="km-asset" key="kmAssetCardLife.fdApplyModelid" />：
								<a target="_blank" onclick="Com_OpenNewWindow(this)" data-href='<c:url value="/km/asset/km_asset_apply_buy/kmAssetApplyBuy.do?method=view&fdId={%data[i].fdApplyModelid%}"/>'>
									{%data[i].fdApplyModelNo%}
								</a>
	                        </p>
	                    </div>
			      $}
			     }
			     if(fdApplyModelname=='com.landray.kmss.km.asset.model.KmAssetApplyChange'){
	             {$
	                  <div class="txt">
	                        <p>{%env.fn.formatText(data[i].fdOperContent)%}</p>
	                        <p class="txtBold"><bean:message bundle="km-asset" key="kmAssetCardLife.fdApplyModelid" />：
								<a target="_blank" onclick="Com_OpenNewWindow(this)" data-href='<c:url value="/km/asset/km_asset_apply_change/kmAssetApplyChange.do?method=view&fdId={%data[i].fdApplyModelid%}"/>'>
									{%data[i].fdApplyModelNo%}
								</a>
	                        </p>
	                    </div>
			      $}
			     }
			     if(fdApplyModelname=='com.landray.kmss.km.asset.model.KmAssetApplyDeal'){
	             {$
	                  <div class="txt">
	                        <p>{%env.fn.formatText(data[i].fdOperContent)%}</p>
	                        <p class="txtBold"><bean:message bundle="km-asset" key="kmAssetCardLife.fdApplyModelid" />：
								<a target="_blank" onclick="Com_OpenNewWindow(this)" data-href='<c:url value="/km/asset/km_asset_apply_deal/kmAssetApplyDeal.do?method=view&fdId={%data[i].fdApplyModelid%}"/>'>
									{%data[i].fdApplyModelNo%}
								</a>
	                        </p>
	                    </div>
			      $}
			     }
			     if(fdApplyModelname=='com.landray.kmss.km.asset.model.KmAssetApplyGet'){
	             {$
	                  <div class="txt">
	                        <p>{%env.fn.formatText(data[i].fdOperContent)%}</p>
	                        <p class="txtBold"><bean:message bundle="km-asset" key="kmAssetCardLife.fdApplyModelid" />：
								<a target="_blank" onclick="Com_OpenNewWindow(this)" data-href='<c:url value="/km/asset/km_asset_apply_get/kmAssetApplyGet.do?method=view&fdId={%data[i].fdApplyModelid%}"/>'>
									{%data[i].fdApplyModelNo%}
								</a>
	                        </p>
	                    </div>
			      $}
			     }
			     if(fdApplyModelname=='com.landray.kmss.km.asset.model.KmAssetApplyIn'){
	             {$
	                  <div class="txt">
	                        <p>{%env.fn.formatText(data[i].fdOperContent)%}</p>
	                        <p class="txtBold"><bean:message bundle="km-asset" key="kmAssetCardLife.fdApplyModelid" />：
								<a target="_blank" onclick="Com_OpenNewWindow(this)" data-href='<c:url value="/km/asset/km_asset_apply_in/kmAssetApplyIn.do?method=view&fdId={%data[i].fdApplyModelid%}"/>'>
									{%data[i].fdApplyModelNo%}
								</a>
	                        </p>
	                    </div>
			      $}
			     }
			     if(fdApplyModelname=='com.landray.kmss.km.asset.model.KmAssetApplyRent'){
	             {$
	                  <div class="txt">
	                        <p>{%env.fn.formatText(data[i].fdOperContent)%}</p>
	                        <p class="txtBold"><bean:message bundle="km-asset" key="kmAssetCardLife.fdApplyModelid" />：
								<a target="_blank" onclick="Com_OpenNewWindow(this)" data-href='<c:url value="/km/asset/km_asset_apply_rent/kmAssetApplyRent.do?method=view&fdId={%data[i].fdApplyModelid%}"/>'>
									{%data[i].fdApplyModelNo%}
								</a>
	                        </p>
	                    </div>
			      $}
			     }
			     if(fdApplyModelname=='com.landray.kmss.km.asset.model.KmAssetApplyRepair'){
	             {$
	                  <div class="txt">
	                        <p>{%env.fn.formatText(data[i].fdOperContent)%}</p>
	                        <p class="txtBold"><bean:message bundle="km-asset" key="kmAssetCardLife.fdApplyModelid" />：
								<a target="_blank" onclick="Com_OpenNewWindow(this)" data-href='<c:url value="/km/asset/km_asset_apply_repair/kmAssetApplyRepair.do?method=view&fdId={%data[i].fdApplyModelid%}"/>'>
									{%data[i].fdApplyModelNo%}
								</a>
	                        </p>
	                    </div>
			      $}
			     }
			     if(fdApplyModelname=='com.landray.kmss.km.asset.model.KmAssetApplyReturn'){
	             {$
	                  <div class="txt">
	                        <p>{%env.fn.formatText(data[i].fdOperContent)%}</p>
	                        <p class="txtBold"><bean:message bundle="km-asset" key="kmAssetCardLife.fdApplyModelid" />：
								<a target="_blank" onclick="Com_OpenNewWindow(this)" data-href='<c:url value="/km/asset/km_asset_apply_return/kmAssetApplyReturn.do?method=view&fdId={%data[i].fdApplyModelid%}"/>'>
									{%data[i].fdApplyModelNo%}
								</a>
	                        </p>
	                    </div>
			      $}
			     }
			     if(fdApplyModelname=='com.landray.kmss.km.asset.model.KmAssetApplyStock'){
	             {$
	                  <div class="txt">
	                        <p>{%env.fn.formatText(data[i].fdOperContent)%}</p>
	                        <p class="txtBold"><bean:message bundle="km-asset" key="kmAssetCardLife.fdApplyModelid" />：
								<a target="_blank" onclick="Com_OpenNewWindow(this)" data-href='<c:url value="/km/asset/km_asset_apply_stock/kmAssetApplyStock.do?method=view&fdId={%data[i].fdApplyModelid%}"/>'>
									{%data[i].fdApplyModelNo%}
								</a>
	                        </p>
	                    </div>
			      $}
			     }
			     if(fdApplyModelname=='com.landray.kmss.km.asset.model.KmAssetApplyInventory'){
		          {$
		            <div class="txt">
                        <p>{%env.fn.formatText(data[i].fdOperContent)%}</p>
                        <p class="txtBold"><bean:message bundle="km-asset" key="kmAssetCardLife.fdApplyModelid" />：
							<a target="_blank" onclick="Com_OpenNewWindow(this)" data-href='<c:url value="/km/asset/km_asset_apply_inventory/kmAssetApplyInventory.do?method=view&fdId={%data[i].fdApplyModelid%}"/>'>
								{%data[i].fdApplyModelNo%}
							</a>
                        </p>
                    </div>
				   $}
				 }
				 if(fdApplyModelname=='com.landray.kmss.km.asset.model.KmAssetCard'){
		          {$
		            <div class="txt">
                        <p>{%env.fn.formatText(data[i].fdOperContent)%}</p>
                        <p class="txtBold"><bean:message bundle="km-asset" key="kmAssetCardLife.fdApplyModelid" />：
							<a target="_blank" onclick="Com_OpenNewWindow(this)" data-href='<c:url value="/km/asset/km_asset_card/kmAssetCard.do?method=view&fdId={%data[i].fdApplyModelid%}"/>'>
								{%data[i].fdApplyModelNo%}
							</a>
                        </p>
                    </div>
				   $}
				 }
			     
	       {$       
	            </div>
                <div class="stream_contentFootL">
                    <div class="stream_contentFootR">
                        <div class="stream_contentFootC"></div>
                    </div>
                </div>
            </div>
            $}
         tmpDate=date;
      }    	
{$</div> </div> $}
}else{
{$
<div class="prompt_container" >
	<div class="prompt_frame">
		<div class="prompt_centerL">
			<div class="prompt_centerR">
				<div class="prompt_centerC">
					<div class="prompt_container clearfloat">
						<div>
							<div class="prompt_content_error"></div>
							<div class="prompt_content_right">
								<div class="prompt_content_inside">
									<bean:message key="return.title" />
									<div class="msgtitle"><bean:message key="return.noRecord"/></div>
									<span class="prompt_content_timer">
										<bean:message key="return.noRecord.msg"/>
									</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
$}
}
