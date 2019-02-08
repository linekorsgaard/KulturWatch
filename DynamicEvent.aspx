<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DynamicEvent.aspx.cs" Inherits="DynamicEvent"  MasterPageFile="~/MasterPage.master" %>
<%@ Register TagPrefix="KW" TagName="SideBar" Src="Sidebar.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <ol class="breadcrumb u-margin-left-1">
        <li><a href="/">KulturWatch</a></li>
        <li runat="server" id="liEvent" class="active"></li>
    </ol>
    <section itemscope itemtype="http://schema.org/Event" class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-8 o-page__col-lg-8">
        <h1 class="u-margin-remove-top">
            <asp:Label ID="lblTitle" runat="server" />
        </h1>
        <p><asp:Label ID="lblDateStart"  itemprop="startDate" runat="server" /> - <asp:Label ID="lblDateEnd"  itemprop="endDate" runat="server" /></p>
        <p><b>Pris:</b> <asp:Label ID="lblPrice" runat="server" /> DKK<br />
            <b>Medlemspris:</b> <asp:Label ID="lblReducedPrice" runat="server" /> DKK</p>
        <asp:Label ID="lblContent" itemprop="review" runat="server" />
    </section>
    <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-4 o-page__col-lg-4">
        <kw:sidebar runat="server" />
    </section>
</asp:Content>
