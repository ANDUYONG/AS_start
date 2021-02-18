<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
	<c:set var="ASbefore" value="${ASbeforeMap.ASbefore}"/>
	<c:set var="repearPartList" value="${ASbeforeMap.repearPartList}"/>
	<c:set var="uNo" value="${sessionScope.member.uNo}"/>

    <meta charset="UTF-8">
    <title>Document</title>
    <!--bootstrap-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>

    <!--jquery-->
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg==" crossorigin="anonymous"></script>

    <!--Calendar js-->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js">
    </script>

    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/js/tempusdominus-bootstrap-4.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/css/tempusdominus-bootstrap-4.min.css" />

    <style>
        body {
            padding: 0;
            margin: 0;
        }
        
        #customerIfTable>table{
        	width: 100%;
        }
        

        #contants{
            width: 100%;
        }

        .headFont {
            font-size: 25px;
            font-weight: bold;
        }

        .contantFont {
            display: inline;
            font-size: 20px;
        }

        #customerInfoTable {
            width: 100%;
        }

        .contantsBox>td {
            width: 70%;
            border-bottom: 1px solid;
            text-align: center;
        }

        .contantsBox>th {
            text-align: left;
            padding-right: 18px;
            width: 30%;
        }

        .contantsBox>th,
        .contantsBox>td {
            padding-top: 40px;
        }

        .InfoText {
            margin-top: 70px;
        }

        .commentsArea {
            resize: none;
            width: 100%;
        }

        #serviseCalendar{
            margin-top: 40px;
            width: 40%;
        }
        
        #serviseCalendar span, #serviseCalendar input{
            font-size: 15px;
        }

        #serviseCalendar>div:nth-child(2) {
            margin-top: 15px;
        }

        #engineerIfTable>table>tbody>tr>th {
            padding-right: 25px;
        }

        #inputPart {
            margin-top: 25px;
        }

        #inputPart>div:nth-last-child(1) {
            margin-top: 5px;
        }

        .partList li {
            text-align: center;
            list-style: none;
        }

        .partList,
        .partList ul {
            padding: 0;
        }

        .partList>li>ul>li {
            width: 33.3%;
            float: left;
        }

        .clearLi {
            clear: both;
        }

        .partListHead>li>ul>li {
            box-sizing: border-box;
            background-color: #6c757d;
            color: #fff;
        }

        .partListHead>li>ul>li:nth-child(1) {
            border-top-left-radius: 10px;
        }

        .partListHead>li>ul>li:nth-last-child(1) {
            border-top-right-radius: 10px;
        }

        .partListContants>li>ul>li:nth-child(3)>p {
            display: inline;
        }
		
		#appendPart{
			margin-top: 100px;
		}
        #appendPart>#appendPartButton {
            background-color: #0d6efd;
            color: white;
            border: 1px solid #0d6efd;
            border-radius: 5px;
            width: 100%;
        }
        #costBox{
            margin-top: 40px;
        }
        #costBox>div{
            width: 40%;
        }
        #submit , #ReviewSubmit{
            width: 11.5%;
            margin: 0 auto;
        }
        #submit>input, #ReviewSubmit>input{
            background-color: #0d6efd;
            color: white;
            border: 1px solid #0d6efd;
            border-radius: 5px;
            width: 100%;
        }

    </style>
    
    <!--jqueryScript-->
    <script>
    	var sta = ${ASbefore.sta};
    	var productNum=${ASbefore.productNo};
    	var selectContent="";
    	var partNoJson;
    	
    	function totalCost(){
    		var allCost=0;
    		$(".cost").each(function(){
    			allCost+=Number($(this).val());
    		});
    		
    		$(".totalCost").val(allCost);
    		
    	}
    	
    	function widthAction(winX){
    		if(winX<=685){
    			$('#serviseCalendar').css({width:'100%'});
    			$('.headFont').css({fontSize:'22px',textAlign: "center"});
    			$('#costBox>div').css({width:'100%'});
    			$('#submit').css({width:'40%'});
    		}else{
    			$('#serviseCalendar').removeAttr('style');
    			$('.headFont').removeAttr('style');
    			$('#costBox>div').removeAttr('style');
    			$('#submit').removeAttr('style');
    		}
    	}
		    	
    	function partList(productNum){
    		$.ajax({
    			type : "post",
    			async : "true",
    			url : "${contextPath}/ASBefore/repearPartList.do",
    			dataType : "json",
    			data : {
    				productNo : productNum
    			},
    			success : function(prdcutJson) {
    				var costJson = prdcutJson[0];
    				partNoJson = prdcutJson[1];
    				var startKey= Object.keys(costJson)[0];
    				selectContent=
    					'<li>\n'+
                        	'<ul>\n'+
                    			  '<li class="clearLi">\n'+
                        		  		'<select class="form-select partSelect">\n';
    				
    				for(var key in costJson){
    					selectContent+="<option value='"+costJson[key]+"'>"+key+"</option>\n";
    				}
    				selectContent +=
    									'</select>\n'+
	                    			'</li>\n'+
	                    			'<li class="input-group mb-3">\n'+
	                    				'<input type="text" class="amount form-control button-addon2" placeholder="수량입력" aria-describedby="button-addon2">\n'+
	                    				'<input type="hidden" class="partNo" value="'+partNoJson[startKey]+'">'+
	                    			'</li>\n'+
				                    '<li class="input-group mb-3">\n'+
										'<input type="text" class="form-control price cost button-addon2" placeholder="0" aria-describedby="button-addon2" readonly>\n'+
										'<button class="btn btn-outline-secondary deleteBtn">\n'+
											'삭제\n'+
										'</button>\n'+
									'</li>\n'+
	                    		'</ul>\n'+
	                    '</li>';
    				
    			},
    			error : function(request, status, error) {
    				alert("로그인 오류입니다. 다시확인후 시도해주세요");
    				location.href="${contextPath}/main/main.do";
    			}
				
    		});
    		
    		
    	}
    	
    	
        $(function() {
        	/*처리중, 처리완료일 경우 tage제어*/
        	if(sta==2){
        		partList(productNum);
        	}else{
        		$(".amount").each(function(){
        			var amount = $(this).val();
        			var cost = $(this).parent().parent().find(".partSelect").val();
        			var price=$(this).parent().parent().find(".price");
        			
        			price.val(cost*amount);
        		});
        		totalCost();
        	}
        	
        	var winX=$(window).width();
        	
        	widthAction(winX);
        	
        	$(window).resize(function() {
        		winX=$(this).width();
        		widthAction(winX);
        	});
        	
        	$("#appendPartButton").click(function(){
        		$(".partListContants").append(selectContent);
        		
        		$(".amount").on("propertychange change keyup paste", function() {
        			
        			var cost=$(this).parent().parent().find(".partSelect").val();
            		var amount=$(this).val();
            		var price=$(this).parent().parent().find(".price");
        			
        			var value=$(this).val();
            		
            		var Pattern=/(^0|[a-z]|[~!@\#$%<>^&*\()\-=+_\’/]|[ㄱ-ㅎ|ㅏ-ㅣ|가-힣])/g;
            		
            		if(Pattern.test(value)){
            			alert('부품 수량의 첫번째 자리가 0이거나 문자가 입력되었습니다.');
                        $(this).val('');
                        price.val(0);
                        totalCost();
                        return false;
                    }
                    if(Pattern.test(value)){
                    	alert('부품 수량의 첫번째 자리가 0이거나 문자가 입력되었습니다.');
                        $(this).val('');
                        price.val(0);
                        totalCost();
                        return false;
                    }
        			
            		if(amount != null && amount.length!=0){
            			price.val(cost*amount);
            		}else{
            			price.val(cost*0);
            		}
            		totalCost();
            	});
        		
        		$(".partSelect").change(function(){
        			$(this).parent().parent().find(".price").val(0);
        			$(this).parent().parent().find(".amount").val(0);
        			
        			var key=$(this).find("option:selected").text();
        			$(this).parent().parent().find(".partNo").val(partNoJson[key]); 

        			totalCost();
        			
        		});
            	
            	$(".deleteBtn").click(function(){
            		$(this).parent().parent().parent().remove();
            		totalCost();
            	});
            	
        	});
        	
        	
        	$(".manPrice").on("propertychange change keyup paste", function() {/*정규식 유효성 검사 구현해야됨*/
				var value=$(this).val();
        		
        		var Pattern=/(^0|[a-z]|[~!@\#$%<>^&*\()\-=+_\’/]|[ㄱ-ㅎ|ㅏ-ㅣ|가-힣])/g;
        		
        		if(Pattern.test(value)){
        			alert('인건비의 첫번째 자리가 0이거나 문자가 입력되었습니다.');
                    $(this).val('');
                    totalCost();
                    return false;
                }
                if(Pattern.test(value)){
                	alert('인건비의 첫번째 자리가 0이거나 문자가 입력되었습니다.');
                    $(this).val('');
                    totalCost();
                    return false;
                }
        		totalCost();
        	});
        	
        	$("#submit").click(function(){
        		var sw=true;
        		var jsonSw=true;
        		var costSw=true;
        		
        		var partNoArray= new Array();
        		var amountArray= new Array();
        		var totalArray= new Array;
        		
        		$(".partNo").each(function(){
        			partNoArray.push($(this).val());
        		});
        		
        		$(".amount").each(function(){
        			amountArray.push(Number($(this).val()));
        		});
        		
        		for(var i=0; i<$(".partNo").length; i++){
					var data = new Object();
					
					if(amountArray[i]>0){
						data.partNo=partNoArray[i];
						data.amount=amountArray[i];
						totalArray.push(data);
					}else{
						jsonSw=false;
					}
        		}
        		if(jsonSw){
	        		if(!totalArray.length>0){
	        			var jsonData = "NotPart";
	        		}else{
	        			var jsonData = JSON.stringify(totalArray);
	        		}
	        		
	        		var inputContent="<input type='hidden' id='partList' value='' name='partList'>";
	        		
	        		$("#addForm").append(inputContent);
	        		
	        		$("#partList").val(jsonData);
        		}else{
        			sw=false;
        		}
        		
        		if(sw){
            		$("#addForm").submit();
        		}else{
        			alert("수량이 없는 부품이 있습니다.");
        		}
        		

        		
        	});
        });
        
    </script>
</head>

<body>
    <div id="container">
        <div id="contants">
            <div id="customerIfTable">
                <table>
                    <tr class="contantsBox">
                        <th class="headFont">고객명</th>
                        <td>
                            <p class="contantFont">${ASbefore.custoname}</p>
                        </td>
                    </tr>
                    <tr class="contantsBox">
                        <th class="headFont">수리기사ID</th>
                        <td>
                            <p class="contantFont">${ASbefore.cuid}</p>
                        </td>
                    </tr>
                    <tr class="contantsBox">
                        <th class="headFont">고객<br>주소</th>
                        <td>
                            <p class="contantFont">${ASbefore.addr}</p>
                        </td>
                    </tr>
                    <tr class="contantsBox">
                        <th class="headFont">a/s제품 분류</th>
                        <td>
                            <p class="contantFont">${ASbefore.prodgroup}</p>
                        </td>
                    </tr>
                    <tr class="contantsBox">
                        <th class="headFont">제조사명</th>
                        <td>
                            <p class="contantFont">${ASbefore.mcrname}</p>
                        </td>
                    </tr>
                    <tr class="contantsBox">
                        <th class="headFont">모델명</th>
                        <td>
                            <p class="contantFont">${ASbefore.proname}</p>
                        </td>
                    </tr>
                    <tr class="contantsBox">
                        <th class="headFont">방문/<br>내방</th>
                        <td>
                        	<c:if test="${ASbefore.meeting==1}">
                            	<p class="contantFont">방문</p>
                            </c:if>
                            <c:if test="${ASbefore.meeting==2}">
                            	<p class="contantFont">내방</p>
                            </c:if>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="InfoText">
                <div>
                    <p class="headFont">증상</p>
                </div>
                <div class="form-floating">
                    <textarea class="form-control commentsArea" placeholder="Leave a comment here" id="floatingTextarea2" style="height: 300px" readonly>${ASbefore.symptoms}</textarea>
                </div>
            </div>

            <div id="serviseCalendar">
                <div class="input-group input-group-sm mb-3">
                    <span class="headFont input-group-text" id="inputGroup-sizing-sm">
                        	희망방문일자
                 	</span>
                    <input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" value="${ASbefore.meetDate}" readonly>
                </div>
                <div class="input-group input-group-sm mb-3">
                    <span class="headFont input-group-text" id="inputGroup-sizing-sm">
                        	기사방문일
                    </span>
                    <input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" value="${ASbefore.respDate}" readonly>
                </div>
            </div>
            
            <c:if test="${ASbefore.sta==2&&uNo==2}">
				<form id="addForm" action="${contextPath}/ASBefore/addASBefore.do" method="post">
					<input type="hidden" name="asno" value="${ASbefore.asno}">

		            <div class="InfoText">
		                <div>
		                    <p class="headFont">수리기사 의견</p>
		                </div>
		                <div class="form-floating">
		                    <textarea name="asComment" class="form-control commentsArea" placeholder="Leave a comment here" id="floatingTextarea2" style="height: 300px">내용</textarea>
		                </div>
		            </div>
		            
		            <div id="inputPart">
		                <p class="headFont">소모품 리스트</p>
		                <!--PartList-->
		                <div>
		                    <ul class="partList partListHead">
		                        <li>
		                            <ul>
		                                <li class="headFont">소모품명</li>
		                                <li class="headFont">수량</li>
		                                <li class="headFont">비용</li>
		                            </ul>
		                        </li>
		                    </ul>
		
		                    <ul class="partList partListContants"><!-- 부품 append -->
		                    
		                    </ul>
		                </div>
		            </div>
		            
		            <div id="appendPart">
		                <input id="appendPartButton" class="headFont" type="button" value="소모품 추가">
		            </div>
	            	
		            <div id="costBox">
		            
		                <div class="input-group input-group-sm mb-3">
		                    <span class="headFont input-group-text" id="inputGroup-sizing-sm">출장비</span>
		                    <input 
		                    	name="serviceCost"
		                    	type="text" 
		                    	class="form-control cost" 
		                    	aria-label="Sizing example input" 
		                    	aria-describedby="inputGroup-sizing-sm" 
		                    	value="${ASbefore.serviceCost}" 
		                    	readonly
		                    >
		                </div>
		                
		                <div class="input-group input-group-sm mb-3">
		                    <span class="headFont input-group-text" id="inputGroup-sizing-sm">인건비</span>
		                    <input 
		                    	name="manCost" 
		                    	type="text" 
		                    	class="form-control manPrice cost" 
		                    	aria-label="Sizing example input" 
		                    	aria-describedby="inputGroup-sizing-sm"
		                    >
		                </div>
		                
		                <div class="input-group input-group-sm mb-3">
		                    <span class="headFont  input-group-text" id="inputGroup-sizing-sm">총합</span>
		                    <input 
		                    	type="text"
		                    	class="form-control totalCost" 
		                    	aria-label="Sizing example input" 
		                    	aria-describedby="inputGroup-sizing-sm" 
		                    	readonly 
		                    	value="0"
		                    >
		                </div>
		                
		            </div>
	            </form>
				<c:if test="${ASbefore.sta==2}">
		            <div id="submit">
		                <input type="button" id="submitBtn" class="headFont" value="수리완료">
		            </div>
	            </c:if>
            </c:if>
            
            <c:if test="${ASbefore.sta==3}">
					<input type="hidden" name="asno" value="${ASbefore.asno}">
					
		            <div class="InfoText">
	                	<div>
		                    <p class="headFont">수리기사 의견</p>
		                </div>
		                <div class="form-floating">
		                    <textarea class="form-control commentsArea" placeholder="Leave a comment here" id="floatingTextarea2" style="height: 300px" readonly>${ASbefore.asComment}</textarea>
		                </div>
		            </div>
		            
		            <div id="inputPart">
		                <p class="headFont">소모품 리스트</p>
		                <!--PartList-->
		                <div>
		                    <ul class="partList partListHead">
		                        <li>
		                            <ul>
		                                <li class="headFont">소모품명</li>
		                                <li class="headFont">수량</li>
		                                <li class="headFont">비용</li>
		                            </ul>
		                        </li>
		                    </ul>
		
		                    <ul class="partList partListContants"><!-- 부품 append -->
								<c:if test="${repearPartList != null}">
									<c:forEach var="repearPart" items="${repearPartList}">
									<li>
										<ul>
											<li class="clearLi">
												<select class="form-select partSelect" disabled>
													<option value="${repearPart.price}">${repearPart.name}</option>
												</select>
											</li>
											<li class="input-group mb-3">
												<input type="text" class="amount form-control button-addon2" placeholder="수량입력" aria-describedby="button-addon2" value="${repearPart.amount}" readonly>
											</li>
											<li class="input-group mb-3">
												<input type="text" class="form-control price cost button-addon2" placeholder="0" aria-describedby="button-addon2" readonly>
											</li>
										</ul>
									</li>
									</c:forEach>
								</c:if>
		                    </ul>
		                </div>
		            </div>
	            	
		            <div id="costBox">
		                <div class="input-group input-group-sm mb-3">
		                    <span class="headFont input-group-text" id="inputGroup-sizing-sm">출장비</span>
		                    <input 
		                    	name="serviceCost"
		                    	type="text" 
		                    	class="form-control cost" 
		                    	aria-label="Sizing example input" 
		                    	aria-describedby="inputGroup-sizing-sm" 
		                    	value="${ASbefore.serviceCost}" 
		                    	readonly
		                    >
		                </div>
		                
	                 	<div class="input-group input-group-sm mb-3">
		                    <span class="headFont input-group-text" id="inputGroup-sizing-sm">인건비</span>
		                    <input
		                    	type="text" 
		                    	class="form-control manPrice cost" 
		                    	aria-label="Sizing example input" 
		                    	aria-describedby="inputGroup-sizing-sm" 
		                    	value="${ASbefore.manCost}" readonly
		                    >
		                </div>
		                		                		                
		                <div class="input-group input-group-sm mb-3">
		                    <span class="headFont  input-group-text" id="inputGroup-sizing-sm">총합</span>
		                    <input 
		                    	type="text"
		                    	class="form-control totalCost" 
		                    	aria-label="Sizing example input" 
		                    	aria-describedby="inputGroup-sizing-sm" 
		                    	readonly 
		                    	value="0"
		                    >
		                </div>
		                
		            </div>
					<div id="ReviewSubmit">
						<button id="ReviewSubmitBtn" type="button" class="btn btn-primary">리뷰작성</button>
					</div>
            </c:if>
        </div>
    </div>

</body>

</html>