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
    <!-- DVWP with DataSourceMode="ListOfLists" -->
    <WebPartPages:DataFormWebPart runat="server" AsyncRefresh="False" FrameType="None" SuppressWebPartChrome="True"
                                  __WebPartId="{BF955286-7CA9-41E1-A769-F4A1986554A6}">
        <ParameterBindings>
            <ParameterBinding Name="UserID" Location="CAMLVariable" DefaultValue="anonymous"/>
        </ParameterBindings>
        <DataFields></DataFields>
        <XslLink>XSLT/ListsAsTiles.xslt</XslLink>
        <Xsl></Xsl>
        <DataSources>
            <SharePoint:SPDataSource runat="server" DataSourceMode="ListOfLists" SelectCommand=""
                                     ID="dsLists"></SharePoint:SPDataSource>
        </DataSources>
    </WebPartPages:DataFormWebPart>
    <!-- DVWP with DataSourceMode="ListOfLists" -->
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


<!-- Inline script for easier readability in HTML source mode -->
<script type="text/javascript">

</script>
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
</body>
</html>
