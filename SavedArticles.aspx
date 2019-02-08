<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SavedArticles.aspx.cs" Inherits="SavedArticles" MasterPageFile="~/MasterPage.master" %>

<%@ Register TagPrefix="KW" TagName="SideBar" Src="Sidebar.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <ol class="breadcrumb u-margin-left-1">
        <li><a href="/">KulturWatch</a></li>
        <li class="active">Gemte artikler</li>
    </ol>
    <div class="o-page__row">
        <iframe src="/SavedArticles.html" class="o-page__col-lg-8 o-page__col-md-8 o-page__col-sm-7 o-page__col-xs-12"></iframe>
        <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-4 o-page__col-lg-4">
            <KW:SideBar runat="server" />
        </section>
    </div>
</asp:Content>
