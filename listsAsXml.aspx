<%@ Page language="C#" inherits="Microsoft.SharePoint.WebPartPages.WebPartPage, Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="SharePoint"
        Namespace="Microsoft.SharePoint.WebControls"
        Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Register tagprefix="WebPartPages" namespace="Microsoft.SharePoint.WebPartPages" assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
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
         <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
         <xsl:template match="@*|node()">  <xsl:copy>    <xsl:apply-templates select="@*|node()"/>  </xsl:copy></xsl:template>
     </xsl:stylesheet>
     </Xsl>
     <DataSources>
         <SharePoint:SPDataSource runat="server" DataSourceMode="ListOfLists" SelectCommand=""
                                  ID="dsLists"></SharePoint:SPDataSource>
     </DataSources>
 </WebPartPages:DataFormWebPart>
