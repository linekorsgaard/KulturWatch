<%@ Application Language="C#" %>
<%@ Import Namespace="System.Web.Routing" %>

<script runat="server">
    // Inspiration from https://www.aspsnippets.com/Articles/Create-dynamic-ASPX-page-in-ASPNet.aspx

    void Application_Start(object sender, EventArgs e)
    {
        RegisterRoutes(RouteTable.Routes);
    }

    static void RegisterRoutes(RouteCollection routes)
    {
        routes.MapPageRoute("DynamicPage", "service/{Page}.aspx", "~/DynamicPage.aspx");
        routes.MapPageRoute("DynamicEvent", "event/{EventName}", "~/DynamicEvent.aspx");
        routes.MapPageRoute("DynamicCategory", "{CategoryName}", "~/DynamicCategory.aspx");
        routes.MapPageRoute("DynamicArticle", "{CategoryName}/{Headline}.aspx", "~/DynamicArticle.aspx");
    }
</script>