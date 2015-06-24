<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<c:set var="calendar" value="${dispatcher.data}"/>
<c:set var="func" value="${dispatcher.function}"/>
<c:set var="month" value="${calendar.month}"/>

<link type="text/css" href="${contextPath}/style/calendar.css" rel="stylesheet"/>
<div class="calendar">
	<c:if test="${dispatcher.function.title != null}">
	<div class="calendar-title-div">
		<span class="calendar-title">${dispatcher.function.title}</span>
	</div>
	</c:if>
	<!-- button -->
	<div class="calendar-dateinfo">
		<span class="calendar-year">${calendar.yearNum}</span>
		<span class="calendar-month">${calendar.monthNum}</span>
	</div>
	<div class="calendar-button-div">
		<a class="button" href="${calendar.preMonthUrl}">이전달</a>
		<a class="button" href="${calendar.nextMonthUrl}">다음달</a>
		<c:forEach var="button" items="${dispatcher.buttons}">
			<span class="button">
				<a href="${button.link}" target="${button.target}"><span class="table-button-text">${button.title}</span></a>
			</span>
		</c:forEach>
	</div>
	<div class="calendar-days">
		<table class="calendar-table" border="0">
			<!-- header -->
			<tr class="calendar-header-tr">
				<th class="calendar-header-td" width="${func.cellWidth}">일요일</th>
				<th class="calendar-header-td" width="${func.cellWidth}">월요일</th>
				<th class="calendar-header-td" width="${func.cellWidth}">화요일</th>
				<th class="calendar-header-td" width="${func.cellWidth}">수요일</th>
				<th class="calendar-header-td" width="${func.cellWidth}">목요일</th>
				<th class="calendar-header-td" width="${func.cellWidth}">금요일</th>
				<th class="calendar-header-td" width="${func.cellWidth}">토요일</th>
			</tr>
			<tr class="calendar-tr">
				<!-- null day -->
				<c:forEach var="day" items="${calendar.nullDays}">
					<td class="calendar-td">
						<div class="calendar-nullday"></div>
					</td>
				</c:forEach>
				<!-- day element -->
				<c:forEach var="day" items="${month.days}">
					<%-- set style class --%>
					<c:choose>
						<c:when test="${day.dayOfWeek == 1 }">
							<c:set var="dayClassName" value="calendar-sunday"/>
						</c:when>
						<c:when test="${day.dayOfWeek == 7 }">
							<c:set var="dayClassName" value="calendar-saturday"/>
						</c:when>
						<c:otherwise>
							<c:set var="dayClassName" value="calendar-day"/>
						</c:otherwise>
					</c:choose>
					<td class="calendar-td" valign="top">
						<div class="${dayClassName}">
							<div class="${dayClassName}-date">${day.day}</div>
							<div class="calendar-list">
								<table class="calendar-list-table" border="0">
									<c:if test="${day.list == null}">
										<tr class="calendar-list-table-tr"><td class="calendar-list-table-td"></td></tr>
									</c:if>
									<c:forEach var="data" items="${day.list}"><%-- data start --%>
										<c:set var="dataCss" value=""/>
										<tr class="calendar-list-table-tr tipTip" title="${data.desc}" style="cursor:pointer;">
											<td class="calendar-list-table-td ${dataCss}" style="padding:1px;" align="center">
											<table><tr>
											<c:forEach var="head" items="${dispatcher.headers}">
												<td align="${head.align}" width="${head.width}">
													<c:if test="${data.renderedData[head.name] != null}">
														<c:set var="cell_data" value="${data.renderedData[head.name]}"/> 
													</c:if>
													<c:if test="${data.renderedData[head.name] == null}">
														<c:set var="cell_data" value="${data[head.name]}"/> 
													</c:if>
													<span class="calendar-list-table-value" id="${month.month}_${day.day}_${data.id}">
														${cell_data}
													</span>
												</td>
											</c:forEach>
											</tr></table>
											</td>
										</tr>
									</c:forEach><%-- data end --%>
								</table>
							</div>
						</div>
					</td>
					<c:if test="${day.dayOfWeek == 7}">
						</tr><tr class="calendar-tr">
					</c:if>
				</c:forEach>
			</tr>
		</table>
	</div>
</div><!-- calendar -->