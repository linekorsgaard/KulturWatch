<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Search.aspx.cs" Inherits="Search" MasterPageFile="~/MasterPage.master" %>

<%@ Register TagPrefix="KW" TagName="SideBar" Src="Sidebar.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="o-page__row">
        <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-8 o-page__col-lg-8">
            <div class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-12 o-page__col-lg-12">
                <h1>Søg</h1>
                <p>
                    Her kan du søge efter artikler på KulturWatch.<br />
                    Der søges både i overskrifter og indhold, så du finder nøjagtigt det, du leder efter.
                </p>
            </div>
            <div class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-6 o-page__col-lg-6 c-highlighted u-padding-1 u-margin-bottom-2 u-margin-top-1">
                <asp:TextBox ID="txtSearch" placeholder="Søgeord" runat="server" CssClass="form-control u-margin-bottom-1"></asp:TextBox>
                <asp:Button ID="btnSearch" CssClass="btn btn-primary" runat="server" Text="Søg" OnClick="btnSearch_Click" />
            </div>
            <div class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-12 o-page__col-lg-12">
                <asp:ListView ID="lvResults" Visible="false" runat="server">
                    <LayoutTemplate>
                        <h2>Resultater</h2>
                        <div runat="server" id="itemPlaceholder" />
                    </LayoutTemplate>
                    <ItemTemplate>
                        <h3><%# Eval("Headline") %></h3>
                        <p><%# Eval("DatePublished") %> | <a href="<%# Eval("CategoryURL")%>"><%# Eval("CategoryName")%> </a></p>
                        <p><%# Eval("Lede") %>.. <a href="/<%# Eval("CategoryURL")%>/<%# Eval("URL")%>.aspx">Læs mere</a></p>
                    </ItemTemplate>
                    <EmptyDataTemplate>
                        <h2>Resultater</h2>
                        <p class="u-margin-bottom-2">Din søgning gav desværre intet resultat.</p>
                    </EmptyDataTemplate>
                </asp:ListView>
            </div>
        </section>
        <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-4 o-page__col-lg-4">
            <KW:SideBar runat="server" />
        </section>
    </div>
</asp:Content>
