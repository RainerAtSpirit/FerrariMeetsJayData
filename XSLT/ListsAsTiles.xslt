<xsl:stylesheet version="1.0" exclude-result-prefixes="xsl ddwrt2 ddwrt msxsl"
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
                <!-- Known issue: Date is in 12 hour format so there's an 12 hour offset if item is changed PM -->
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
