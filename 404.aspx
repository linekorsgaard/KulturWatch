<%@ Page Language="C#" AutoEventWireup="true" CodeFile="404.aspx.cs" Inherits="_404" MasterPageFile="~/MasterPage.master" %>

<%@ Register TagPrefix="KW" TagName="SideBar" Src="Sidebar.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="o-page__row">
        <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-8 o-page__col-lg-8">
            <h1>Ups!</h1>
            <p> Siden, du leder efter, eksisterer ikke.</p>
            <p>Er linket i stykker, kontakt venligst Esben på <a href="mailto:esben@infowatch.dk">esben@infowatch.dk</a>. Ellers brug vores søgeside.</p>
            <p><a class="btn btn-primary" href="/Search.aspx">Gå til søgeside</a></p>
        </section>
        <section class="o-page__col-xs-12 o-page__col-lg-4 o-page__col-md-4 o-page__col-sm-12">
            <KW:SideBar runat="server" />
        </section>
    </div>
</asp:Content>
