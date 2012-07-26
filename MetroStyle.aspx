<!DOCTYPE HTML>
<%@ Page language="C#" inherits="Microsoft.SharePoint.WebPartPages.WebPartPage, Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="SharePoint"
        Namespace="Microsoft.SharePoint.WebControls"
        Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Register tagprefix="WebPartPages" namespace="Microsoft.SharePoint.WebPartPages" assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
        <!-- paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/ -->
        <!--[if lt IE 7]>
        <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
        <!--[if IE 7]>
        <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
        <!--[if IE 8]>
        <html class="no-js lt-ie9" lang="en"> <![endif]-->
        <!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
<head>

    <!-- Set the viewport width to device width for mobile -->
    <meta name="viewport" content="width=device-width"/>

    <title>The Ferrari meets JayData</title>

    <!-- Included metroJS CSS  -->
    <link rel="stylesheet" type="text/css" href="stylesheets/MetroJs.css"/>

    <!-- Included CSS Files Production -->
    <link rel="stylesheet" href="stylesheets/prod.css"/>

    <script src="libs/modernizr.foundation.js"></script>

    <script data-main="js/main" src="libs/require.js"></script>
    <script type="text/javascript">
        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', 'UA-31072569-1']);
        _gaq.push(['_trackPageview']);
    </script>
    <!-- IE Fix for HTML5 Tags -->
    <!--[if lt IE 9]>
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

</head>
<body>

<div class="row">
    <div class="twelve columns">
        <h1>The Ferrari meets JayData</h1>

        <p>Live demo for an upcoming blog post at <a href="http://rainerat.spirit.de/">Rainer at Spirit</a></p>

        <div id="loginHelper">
            <div data-bind="visible: userId !== 'anonymous' " style="display: none;">
                You're logged on as: <span class="success label" data-bind="text: userId"></span>
            </div>
            <div data-bind="visible: userId === 'anonymous' " style="display: none;">
                <a href="#" data-bind="attr: {href: loginURL}" class="button"> Sign
                    in</a>
                with username: <span class="secondary label">ODataDemo</span> password: <span class="secondary label">OData!Demo</span>
            </div>
        </div>
        <hr/>
    </div>
</div>
<div class="row">
    <div id="metroTiles" class="twelve columns tiles" data-bind="foreach: TileData">
        <div class="live-tile" data-stops="100%" data-speed="750" data-delay="-1"
             data-bind="class: color + ' ' + size ,
           attr: {'data-mode': mode ? mode : '', 'data-direction': direction} ,
           click: $root.goToDetail">
            <span class="tile-title" data-bind="text: title"></span>
            <span class="badge" data-bind="text: count"></span>

            <div>
                <img class="micon" data-bind="attr: {src: icon}"/>
            </div>
            <div>
                <h3 data-bind="text: backTitle"></h3>
                <span class="prettyDate" data-bind="attr: {title: prettyDate}"></span>
            </div>
        </div>
    </div>
</div>
<!-- Draft version -->
<div class="row" id="listingView">
    <h3 data-bind="text: $root.selectedList"></h3>
    <table>
        <thead>
        <tr>
            <th>Id</th>
            <th>Title</th>
            <th>Created</th>
            <th>CreatedBy</th>
        </tr>
        </thead>
        <tbody data-bind="foreach: allItems">
        <tr>
            <td><a href="#" data-bind="text: Id"></a></td>
            <td data-bind="text: Title"></td>
            <td data-bind="text: Created"></td>
            <td data-bind="text: CreatedBy"></td>
        </tr>
        </tbody>
    </table>
</div>

<SharePoint:FormDigest ID="FormDigest1" runat="server"></SharePoint:FormDigest>

<script type="text/javascript">
    (function () {
        var ga = document.createElement('script');
        ga.type = 'text/javascript';
        ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0];
        s.parentNode.insertBefore(ga, s);
    })();
</script>



<!-- Using <XslLink>XSLT/ListsAsTiles.xslt sometimes throws the error "Error while delta-compile custom Xsl for
dataformwebpart: System.Xml.Xsl.XslLoadException: XSLT compile error. An error occurred  at (109,1).
System.InvalidOperationException: Operation is not valid due to the current state of the object.
Using <XSL> instead </XslLink>-->
<!-- DVWP with DataSourceMode="ListOfLists" -->

 <WebPartPages:DataFormWebPart runat="server" AsyncRefresh="False" FrameType="None" SuppressWebPartChrome="True"
                               __WebPartId="{BF955286-7CA9-41E1-A769-F4A1986554A6}">
     <ParameterBindings>
         <ParameterBinding Name="UserID" Location="CAMLVariable" DefaultValue="anonymous"/>
     </ParameterBindings>
     <DataFields></DataFields>
     <Xsl><xsl:stylesheet version="1.0" exclude-result-prefixes="xsl ddwrt2 ddwrt msxsl"
                     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                     xmlns:ddwrt2="urn:frontpage:internal"
                     xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime"
                     xmlns:msxsl="urn:schemas-microsoft-com:xslt">
         <xsl:import href="XSLT/xml2json.xslt"/>
         <xsl:output method="html" version="1.0" encoding="UTF-8" indent="no"/>
         <xsl:param name="UserID"></xsl:param>
         <xsl:variable name="Rows"
                       select="/dsQueryResponse/Rows/Row[not(@__spHidden = 'True') and not(contains(@__spDefaultViewUrl, '_catalogs')) and @__spTitle != 'ServiceFiles']"/>

         <!-- configMap global configuration, configuration per BaseTemplate and tileData -->
         <xsl:variable name="configMap">
             <global>
                 <maxTiles>12</maxTiles>
                 <wideTilesThreshold>50</wideTilesThreshold>
                 <backTileTitle>Last Updated</backTileTitle>
             </global>
             <baseTemplate>
                 <item btId="Contacts" color="lime" icon="images/48/bomb.png"/>
                 <item btId="DocumentLibrary" color="teal" icon="images/48/file.png" mode="slide"
                       direction="vertical"/>
                 <item btId="GenericList" color="green" icon="images/48/inventory2.png" mode="flip"
                       direction="vertical"/>
                 <item btId="Tasks" color="red" icon="images/48/bomb.png" mode="flip"
                       direction="horizontal"/>
                 <item btId="GanttTasks" color="purple" icon="images/48/hand_thumbsup.png"/>
                 <item btId="IssueTracking" color="pink" icon="images/48/clipboard.png" mode="slide"
                       direction="vertical"/>
                 <item btId="Links" color="lime" icon="images/48/link.png"/>
                 <item btId="WebPageLibrary" color="brown" icon="images/48/clipboard.png"/>
                 <item btId="Events" color="mango" icon="images/48/clipboard.png"/>
                 <item btId="unknown" color="blue" icon="images/48/smiley_sad.png" mode="" direction=""/>
             </baseTemplate>
             <userId>
                 <xsl:choose>
                     <xsl:when test="$UserID !='anonymous' ">
                         <xsl:value-of select="substring-after($UserID, '\')" />
                     </xsl:when>
                     <xsl:otherwise>anonymous</xsl:otherwise>
                 </xsl:choose>
             </userId>
         </xsl:variable>

         <xsl:variable name="tileData">
             <tiles>
                 <xsl:for-each select="$Rows">
                     <xsl:sort
                             select="translate(substring-before(substring-after(@__spPropertiesXml, 'Modified=&quot;'), '&quot; LastDeleted'), ' :', '')"
                             order="descending" data-type="number"/>
                     <xsl:if test="position() &lt;= $configMapNS/global/maxTiles">
                         <xsl:variable name="coreMetaData">
                             <xsl:call-template name="MetaData">
                                 <xsl:with-param name="currItem" select="current()"/>
                                 <xsl:with-param name="pos" select="position()"/>
                             </xsl:call-template>
                         </xsl:variable>
                         <tile listId="{@__spID}" title="{@__spTitle}" count="{@__spItemCount}" pos="{position()}">
                             <xsl:copy-of select="msxsl:node-set($coreMetaData)/metaData/@*"/>
                         </tile>
                     </xsl:if>
                 </xsl:for-each>
             </tiles>
         </xsl:variable>

         <xsl:variable name="configMapNS" select="msxsl:node-set($configMap)"/>
         <xsl:variable name="tileDataNS" select="msxsl:node-set($tileData)"/>


         <xsl:template match="/">
             <script type="text/javascript">
                 var app = window.app || {};
                 app.configMap =<xsl:apply-templates select="$configMapNS/*"/>;
                 app.tilesData =<xsl:apply-templates select="$tileDataNS/*"/>;
             </script>
         </xsl:template>

         <xsl:template name="MetaData">
             <xsl:param name="currItem"/>
             <xsl:param name="pos"/>
             <xsl:variable name="btConfigNS" select="$configMapNS/baseTemplate"/>
             <metaData>
                 <xsl:attribute name="backTitle">
                     <xsl:value-of select="$configMapNS/global/backTileTitle" />
                 </xsl:attribute>
                 <xsl:attribute name="prettyDate">
                     <xsl:variable name="dateRaw"
                                   select="translate(substring-before(substring-after($currItem/@__spPropertiesXml, 'Modified=&quot;'), '&quot; LastDeleted'), ' ', 'T')"/>
                     <xsl:value-of
                             select="concat(substring($dateRaw, 1, 4), '-', substring($dateRaw, 5, 2), '-', substring($dateRaw, 7,2), substring($dateRaw, 9), 'Z')"/>
                 </xsl:attribute>
                 <xsl:attribute name="size">
                     <xsl:choose>
                         <xsl:when test="$currItem/@__spItemCount &gt;= $configMapNS/global/wideTilesThreshold">
                             <xsl:text>wide</xsl:text>
                         </xsl:when>
                         <xsl:otherwise/>
                     </xsl:choose>
                 </xsl:attribute>
                 <!-- merge with $tileConfig -->
                 <xsl:copy-of select="$btConfigNS/item[@btId = 'unknown']/@*"/>
                 <xsl:copy-of select="$btConfigNS/item[@btId =  $currItem/@__spBaseTemplate]/@*"/>
             </metaData>
         </xsl:template>
     </xsl:stylesheet>
     </Xsl>
     <DataSources>
         <SharePoint:SPDataSource runat="server" DataSourceMode="ListOfLists" SelectCommand=""
                                  ID="dsLists"></SharePoint:SPDataSource>
     </DataSources>
 </WebPartPages:DataFormWebPart>
 <!-- DVWP with DataSourceMode="ListOfLists" -->

</body>
</html>
