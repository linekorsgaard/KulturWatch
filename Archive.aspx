<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Archive.aspx.cs" Inherits="Archive"  MasterPageFile="~/MasterPage.master" %>
<%@ Register TagPrefix="KW" TagName="SideBar" Src="Sidebar.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <ol class="breadcrumb u-margin-left-1">
        <li><a href="/">KulturWatch</a></li>
        <li runat="server" class="active">Arkiv</li>
    </ol>
    <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-8 o-page__col-lg-8 u-remove-padding">
        <asp:ListView ID="lvArchive" runat="server">
            <LayoutTemplate>
                <h1>Arkiv</h1>
                <ul class="o-list">
                    <li runat="server" id="itemPlaceholder" />
                </ul>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="u-margin-top-1">
                    <div class="media-left u-text-discrete">
                        <%# Eval("Date") %>
                    </div>
                    <div class="media-body">
                        <a href="/<%# Eval("CategoryURL") %>/<%# Eval("URL") %>.aspx"><%# Eval("Headline") %></a>
                    </div>
                </div>
            </ItemTemplate>
            <EmptyDataTemplate>
                <p class="u-margin-bottom-2">Der er ingen begivenheder i den nærmeste fremtid.</p>
            </EmptyDataTemplate>
        </asp:ListView>
    </section>
    <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-4 o-page__col-lg-4">
        <kw:sidebar runat="server" />
    </section>
</asp:Content>
