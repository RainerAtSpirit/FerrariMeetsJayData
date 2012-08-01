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

    <script type="text/javascript">
        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', 'UA-31072569-1']);
        _gaq.push(['_trackPageview']);
    </script>
    <!-- IE Fix for HTML5 Tags -->
    <!--[if lt IE 9]>
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <script data-main="js/main" src="libs/require.js"></script>
</head>
<body>

<div class="row">
    <div class="twelve columns">
        <h1>The Ferrari meets JayData</h1>
        <h2 class="subheader">Running on premise on SP2010 foundation</h2>
        <p>Live demo for an upcoming blog post at <a href="http://rainerat.spirit.de/">Rainer at Spirit</a>.  See
            this demo running hosted on <a
                        href="https://spirit2013preview-public.sharepoint.com/zurbv3/MetroStyle.aspx">SP2013
                    Preview</a></p>

        <div id="logonVM">
            <div data-bind="visible: userId() !== 'anonymous' " style="display: none;">
                You're logged on as: <span class="success label" data-bind="text: userId"></span>
            </div>
            <div data-bind="visible: userId() === 'anonymous' " style="display: none;">
                <a href="#" data-bind="attr: {href: loginURL}" class="button"> Sign
                    in</a>
                with username: <span class="secondary label">ODataDemo</span> password: <span class="secondary label">OData!Demo</span>
            </div>
       <!--     <h3 class="subheader">Debugging info:</h3>
            <div class="debug" data-bind="text: ko.toJSON($root)"></div>-->
        </div>
        <hr/>
    </div>
</div>
<div class="row">
    <div id="tileVM" class="twelve columns tiles">
        <!--<h3 class="subheader">Debugging info:</h3>
        <div class="debug" data-bind="text: ko.toJSON($root)"></div>-->
        <!-- ko foreach: TileData -->
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
        <!-- /ko -->
    </div>
</div>

<div class="row" id="listingVM">

    <div class="nine columns" style="display:none"
         data-bind="if: showTable(),
         style: { display: showTable() ? 'block' : 'none' }">
        <div class="twelve columns">
            <div class="two columns">
                <a href="#" title="Go back"><img src="images/48/arrow_left.png"  style="border: none"/></a>
            </div>
            <div class="ten columns">
                <h3 data-bind="text: $root.selectedList"></h3>
            </div>
        </div>
        <div class="twelve columns" data-bind="foreach: allItems, updateDetailTileOnce: true" >
                <div class="live-tile blue" data-bind="click: $root.showDetails" data-mode="flip">
                   <div>
                       <h3 data-bind="text: Title"></h3>
                       <span class="tile-title prettyDate"
                           data-bind="text: Modified, attr: {title: new Date(Modified).toISOString().substring(0,19) + 'Z'}"></span>
                       <span class="badge" data-bind="text: Id"></span>
                   </div>
                   <div>
                       <p>Here would be room for more information, but for this demo we simply show all infos on the
                           right.</p>
                   </div>
                </div>
        </div>
    </div>
    <div class="three columns" style="display:none"  data-bind="if: itemDetail().length > 0,
             style: { display: showTable() ? 'block' : 'none' }">
        <h3>Detail info</h3>
            <ul class="disc" data-bind="foreach: { data: itemDetail}">
                <li>
                    <span data-bind="text: key"></span>
                    <span class="secondary label" data-bind="text: val"></span>
                </li>
            </ul>
    </div>
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
         <!--<xsl:import href="XSLT/xml2json.xslt"/>-->
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
                 <item btId="DocumentLibrary" color="teal" icon="images/48/file.png"/>
                 <item btId="GenericList" color="green" icon="images/48/inventory2.png"/>
                 <item btId="Tasks" color="red" icon="images/48/bomb.png" mode="flip"
                       direction="horizontal"/>
                 <item btId="GanttTasks" color="purple" icon="images/48/hand_thumbsup.png"/>
                 <item btId="IssueTracking" color="pink" icon="images/48/clipboard.png"/>
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

         <!--
           Copyright (c) 2006, Doeke Zanstra
           All rights reserved.

           Redistribution and use in source and binary forms, with or without modification,
           are permitted provided that the following conditions are met:

           Redistributions of source code must retain the above copyright notice, this
           list of conditions and the following disclaimer. Redistributions in binary
           form must reproduce the above copyright notice, this list of conditions and the
           following disclaimer in the documentation and/or other materials provided with
           the distribution.

           Neither the name of the dzLib nor the names of its contributors may be used to
           endorse or promote products derived from this software without specific prior
           written permission.

           THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
           ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
           WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
           IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
           INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
           BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
           DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
           LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
           OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
           THE POSSIBILITY OF SUCH DAMAGE.
         -->

                <!-- Improvements 2009 01 22: Martynas Jusevičius http://www.xml.lt -->
           <!-- XML2JSON conversion -->

             <!-- used to identify unique children in Muenchian groupin -->
             <xsl:key name="elements-by-name" match="@* | *" use="concat(generate-id(..), '@', name(.))"/>

             <!-- XML2JSON conversion -->
             <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'"/>
             <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>

             <!-- include attributes in result? -->
             <xsl:param name="include-attrs" select="true()"/>

             <!--constant-->
             <xsl:variable name="d">0123456789</xsl:variable>




             <!-- ignore document text -->
             <xsl:template match="text()[preceding-sibling::node() or following-sibling::node()]"/>

             <!-- string -->
             <xsl:template match="text()">
                 <!-- RainetAtSpirit: Adding support for correct handling of elements with attributes.
               e.g. <Value Type="Counter">%ListItemID%</Value>
               -->
                 <xsl:if test="../@* and ../text()">"text":</xsl:if>
                 <xsl:call-template name="process-values">
                     <xsl:with-param name="s" select="."/>
                 </xsl:call-template>
                 <xsl:if test="../@* and ../text()">}</xsl:if>
             </xsl:template>

             <!-- text values (from text nodes and attributes) -->
             <xsl:template name="process-values">
                 <xsl:param name="s"/>
                 <xsl:choose>
                     <!-- number -->
                     <xsl:when test="not(string(number($s))='NaN')">
                         <xsl:value-of select="$s"/>
                     </xsl:when>
                     <!-- boolean -->
                     <xsl:when test="translate($s,'TRUE','true')='true'">true</xsl:when>
                     <xsl:when test="translate($s,'FALSE','false')='false'">false</xsl:when>
                     <!-- string -->
                     <xsl:otherwise>
                         <xsl:call-template name="escape-string">
                             <xsl:with-param name="s" select="$s"/>
                         </xsl:call-template>
                     </xsl:otherwise>
                 </xsl:choose>
             </xsl:template>

             <!-- Main template for escaping strings; used by above template and for object-properties
              Responsibilities: placed quotes around string, and chain up to next filter, escape-bs-string -->
             <xsl:template name="escape-string">
                 <xsl:param name="s"/>
                 <xsl:text>"</xsl:text>
                 <xsl:call-template name="escape-bs-string">
                     <xsl:with-param name="s" select="$s"/>
                 </xsl:call-template>
                 <xsl:text>"</xsl:text>
             </xsl:template>

             <!-- Escape the backslash (\) before everything else. -->
             <xsl:template name="escape-bs-string">
                 <xsl:param name="s"/>
                 <xsl:choose>
                     <xsl:when test="contains($s,'\')">
                         <xsl:call-template name="escape-quot-string">
                             <xsl:with-param name="s" select="concat(substring-before($s,'\'),'\\')"/>
                         </xsl:call-template>
                         <xsl:call-template name="escape-bs-string">
                             <xsl:with-param name="s" select="substring-after($s,'\')"/>
                         </xsl:call-template>
                     </xsl:when>
                     <xsl:otherwise>
                         <xsl:call-template name="escape-quot-string">
                             <xsl:with-param name="s" select="$s"/>
                         </xsl:call-template>
                     </xsl:otherwise>
                 </xsl:choose>
             </xsl:template>

             <!-- Escape the double quote ("). -->
             <xsl:template name="escape-quot-string">
                 <xsl:param name="s"/>
                 <xsl:choose>
                     <xsl:when test="contains($s,'&quot;')">
                         <xsl:call-template name="encode-string">
                             <xsl:with-param name="s" select="concat(substring-before($s,'&quot;'),'\&quot;')"/>
                         </xsl:call-template>
                         <xsl:call-template name="escape-quot-string">
                             <xsl:with-param name="s" select="substring-after($s,'&quot;')"/>
                         </xsl:call-template>
                     </xsl:when>
                     <xsl:otherwise>
                         <xsl:call-template name="encode-string">
                             <xsl:with-param name="s" select="$s"/>
                         </xsl:call-template>
                     </xsl:otherwise>
                 </xsl:choose>
             </xsl:template>

             <!-- Replace tab, line feed and/or carriage return by its matching escape code. Can't escape backslash
              or double quote here, because they don't replace characters (&#x0; becomes \t), but they prefix
              characters (\ becomes \\). Besides, backslash should be seperate anyway, because it should be
              processed first. This function can't do that. -->
             <xsl:template name="encode-string">
                 <xsl:param name="s"/>
                 <xsl:choose>
                     <!-- tab -->
                     <xsl:when test="contains($s,'&#x9;')">
                         <xsl:call-template name="encode-string">
                             <xsl:with-param name="s"
                                             select="concat(substring-before($s,'&#x9;'),'\t',substring-after($s,'&#x9;'))"/>
                         </xsl:call-template>
                     </xsl:when>
                     <!-- line feed -->
                     <xsl:when test="contains($s,'&#xA;')">
                         <xsl:call-template name="encode-string">
                             <xsl:with-param name="s"
                                             select="concat(substring-before($s,'&#xA;'),'\n',substring-after($s,'&#xA;'))"/>
                         </xsl:call-template>
                     </xsl:when>
                     <!-- carriage return -->
                     <xsl:when test="contains($s,'&#xD;')">
                         <xsl:call-template name="encode-string">
                             <xsl:with-param name="s"
                                             select="concat(substring-before($s,'&#xD;'),'\r',substring-after($s,'&#xD;'))"/>
                         </xsl:call-template>
                     </xsl:when>
                     <xsl:otherwise>
                         <xsl:value-of select="$s"/>
                     </xsl:otherwise>
                 </xsl:choose>
             </xsl:template>

             <!-- object -->
             <xsl:template match="*">
                 <!-- checks if this node should be in array (ie there are more siblings with the same name) -->
                 <xsl:variable name="in-array"
                               select="count(key('elements-by-name', concat(generate-id(..), '@', name(.)))) &gt; 1"/>
                 <xsl:if test="position() = 1">{
                 </xsl:if>
                 <xsl:call-template name="escape-string">
                     <xsl:with-param name="s" select="name()"/>
                 </xsl:call-template>
                 <xsl:text>:</xsl:text>
                 <!-- if not in array, apply templates on unique children (which may represent a group of more than one, that becomes an array) -->
                 <xsl:if test="not($in-array)">
                     <xsl:choose>
                         <xsl:when test="@* | child::node()">
                             <xsl:if test="$include-attrs">
                                 <xsl:apply-templates
                                         select="@* | *[generate-id(.) = generate-id(key('elements-by-name', concat(generate-id(..), '@', name(.)))[1])] | text()"/>
                             </xsl:if>
                             <xsl:if test="not($include-attrs)">
                                 <xsl:apply-templates
                                         select="*[generate-id(.) = generate-id(key('elements-by-name', concat(generate-id(..), '@', name(.)))[1])] | text()"/>
                             </xsl:if>
                         </xsl:when>
                         <xsl:otherwise>null</xsl:otherwise>
                     </xsl:choose>
                 </xsl:if>
                 <!-- if in array, apply templates on a group of equally-named sibling nodes -->
                 <xsl:if test="$in-array">
                     <xsl:apply-templates select="key('elements-by-name', concat(generate-id(..), '@', name(.)))" mode="array"/>
                 </xsl:if>
                 <xsl:if test="position() != last()">,
                 </xsl:if>
                 <xsl:if test="position() = last()">}
                 </xsl:if>
             </xsl:template>

             <!-- array -->
             <xsl:template match="*" mode="array">
                 <xsl:if test="position() = 1">[
                 </xsl:if>
                 <xsl:choose>
                     <xsl:when test="@* | child::node()">
                         <xsl:if test="$include-attrs">
                             <xsl:apply-templates
                                     select="@* | *[generate-id(.) = generate-id(key('elements-by-name', concat(generate-id(..), '@', name(.)))[1])] | text()"/>
                         </xsl:if>
                         <xsl:if test="not($include-attrs)">
                             <xsl:apply-templates
                                     select="*[generate-id(.) = generate-id(key('elements-by-name', concat(generate-id(..), '@', name(.)))[1])] | text()"/>
                         </xsl:if>
                     </xsl:when>
                     <xsl:otherwise>null</xsl:otherwise>
                 </xsl:choose>
                 <xsl:if test="position() != last()">,
                 </xsl:if>
                 <xsl:if test="position() = last()">]
                 </xsl:if>
             </xsl:template>

             <!-- attributes -->
             <xsl:template match="@*">
                 <xsl:if test="position() = 1">{
                 </xsl:if>
                 <xsl:call-template name="escape-string">
                     <xsl:with-param name="s" select="name()"/>
                 </xsl:call-template>
                 <xsl:text>:</xsl:text>
                 <xsl:call-template name="process-values">
                     <xsl:with-param name="s" select="."/>
                 </xsl:call-template>
                 <xsl:if test="position() != last()">,
                 </xsl:if>
                 <xsl:if test="position() = last()">}
                 </xsl:if>
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
