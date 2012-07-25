<xsl:stylesheet version="1.0"
                exclude-result-prefixes="xsl ddwrt2 ddwrt msxsl"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ddwrt2="urn:frontpage:internal"
                xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
        >
    <xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:variable name="Rows"
                  select="/dsQueryResponse/Rows/Row[not(@__spHidden = 'True') and not(contains(@__spDefaultViewUrl, '_catalogs')) and @__spTitle != 'ServiceFiles']"/>

    <!-- configMap allows configuration per BaseTemplate -->
    <xsl:variable name="configMap">
        <item BaseTemplate="Contacts" color="lime" icon="images/48/bomb.png"/>
        <item BaseTemplate="DocumentLibrary" color="teal" icon="images/48/file.png"/>
        <item BaseTemplate="GenericList" color="green" icon="images/48/inventory2.png"/>
        <item BaseTemplate="Tasks" color="red" icon="images/48/bomb.png"/>
        <item BaseTemplate="GanttTasks" color="purple" icon="images/48/hand_thumbsup.png"/>
        <item BaseTemplate="IssueTracking" color="pink" icon="images/48/clipboard.png"/>
        <item BaseTemplate="Links" color="lime" icon="images/48/link.png"/>
        <item BaseTemplate="WebPageLibrary" color="brown" icon="images/48/clipboard.png"/>
        <item BaseTemplate="Events" color="mango" icon="images/48/clipboard.png"/>
    </xsl:variable>

    <!-- itemsInList sorted by @__spItemCount descending. Used to distinguish between normal and wide tiles  -->
    <xsl:variable name="itemsInList">
        <xsl:for-each select="$Rows">
            <xsl:sort select="@__spItemCount" order="descending" data-type="number"/>
            <item id="{@__spID}" count="{@__spItemCount}" pos="{position()}"/>
        </xsl:for-each>
    </xsl:variable>


    <xsl:template match="/">
        <xsl:for-each select="$Rows">
            <xsl:sort
                    select="translate(substring-before(substring-after(@__spPropertiesXml, 'Modified=&quot;'), '&quot; LastDeleted'), ' :', '')"
                    order="descending" data-type="number"/>
            <xsl:if test="position() &lt; 13">
                <xsl:call-template name="Tile"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="Tile">
        <xsl:variable name="baseTemplate" select="@__spBaseTemplate"/>
        <xsl:variable name="spID" select="@__spID"/>
        <xsl:variable name="color">
            <xsl:choose>
                <xsl:when test="msxsl:node-set($configMap)/item[@BaseTemplate = $baseTemplate]">
                    <xsl:value-of select="msxsl:node-set($configMap)/item[@BaseTemplate = $baseTemplate]/@color"/>
                </xsl:when>
                <xsl:otherwise>blue</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="icon">
            <xsl:choose>
                <xsl:when test="msxsl:node-set($configMap)/item[@BaseTemplate = $baseTemplate]">
                    <xsl:value-of select="msxsl:node-set($configMap)/item[@BaseTemplate = $baseTemplate]/@icon"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@__spImageUrl"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="size">
            <xsl:choose>
                <xsl:when test="msxsl:node-set($itemsInList)/item[@id = $spID]/@pos &lt; 4">
                    <xsl:text>wide</xsl:text>
                </xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="DateRaw"
                      select="translate(substring-before(substring-after(@__spPropertiesXml, 'Modified=&quot;'), '&quot; LastDeleted'), ' ', 'T')"/>
        <xsl:variable name="PrettyDateUTC"
                      select="concat(substring($DateRaw, 1, 4), '-', substring($DateRaw, 5, 2), '-', substring($DateRaw, 7,2), substring($DateRaw, 9), 'Z')"/>

        <xsl:variable name="mode">
            <xsl:choose>
                <xsl:when test="$size = 'wide'">slide</xsl:when>
                <xsl:otherwise>flip</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <div id="{concat('tile-', position())}" class="live-tile {$color} {$size}" data-mode="{$mode}" data-stops="100%"
             data-speed="750"
             data-delay="-1" data-target="{@__spDefaultViewUrl}" data-baseTemplate="{@__spBaseTemplate}">
            <span class="tile-title">
                <xsl:value-of select="@__spTitle"/>
                <span class="badge right">
                    <xsl:value-of select="@__spItemCount"/>
                </span>
            </span>
            <div>
                <img src="{$icon}" class="micon"/>
            </div>
            <div>
                <h3>
                    <xsl:text>Last updated</xsl:text>
                </h3>
                <span class="prettyDate" title="{$PrettyDateUTC}">
                    <xsl:value-of select="$PrettyDateUTC"/>
                </span>
            </div>
        </div>
    </xsl:template>

</xsl:stylesheet>