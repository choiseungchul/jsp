<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.jfree.chart.*"%>
<%@ page import="org.jfree.chart.plot.*"%>
<%@ page import="org.jfree.chart.axis.*"%>
<%@ page import="org.jfree.chart.title.*"%>
<%@ page import="java.awt.*"%>
<%@ page import="java.util.*"%>
<%@ page import="de.laures.cewolf.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<%@ taglib uri="http://cewolf.sourceforge.net/taglib/cewolf.tld" prefix="cewolf" %>
<!-- /*
	 *  area, areaxy, horizontalbar, horizontalbar3d, line, pie, 
	 *  scatter, stackedhorizontalbar, stackedverticalbar, stackedverticalbar3d, timeseries, 
	 *  verticalbar, verticalbar3d, xy, candlestick, highlow, gantt, wind, 
	 *  signal, verticalxybar, pie3d
	 */ -->
<cewolf:chart id="chart_${dispatcher.function.id}" type="${dispatcher.function.chartType}" showlegend="${dispatcher.function.useLegend}" title="${dispatcher.function.title}">
    <cewolf:data>
        <cewolf:producer id="${dispatcher.function.id}"/>
    </cewolf:data>
    <cewolf:chartpostprocessor id="${dispatcher.function.id}_cpp">
    	<cewolf:param name="basefont" value="nanum"></cewolf:param>
    	<cewolf:param name="title-font" value="batang"></cewolf:param>
    	<cewolf:param name="legend-font" value="gulim"></cewolf:param>
    	<cewolf:param name="legend-size" value="12"></cewolf:param>
    </cewolf:chartpostprocessor>
</cewolf:chart>
<cewolf:img chartid="chart_${dispatcher.function.id}" renderer="/cewolf" width="${dispatcher.function.chartWidth}" height="${dispatcher.function.chartHeight}"/>