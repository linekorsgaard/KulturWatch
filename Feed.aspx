<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Feed.aspx.cs" Inherits="Feed" MasterPageFile="MasterPage.master" MaintainScrollPositionOnPostback="true" %>

<%@ Register TagPrefix="KW" TagName="SideBar" Src="Sidebar.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <ol class="breadcrumb u-margin-left-1">
        <li><a href="/">KulturWatch</a></li>
        <li class="active">Mit feed</li>
    </ol>
    <div class="o-page__row">
        <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-8 o-page__col-lg-8">
            <div class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-12 o-page__col-lg-12">
                <h1>Mit feed</h1>
                <asp:ListView ID="lvFeed" runat="server">
                    <ItemTemplate>
                        <div class="c-highlighted u-padding-1 u-margin-bottom-2">
                            <a class="u-link-anonymous" href="/<%# Eval("CategoryURL") %>/<%# Eval("URL") %>.aspx">
                                <asp:Image ImageUrl='<%# Eval("ImagePath") %>' runat="server" />
                                <h2 class="h3">
                                    <asp:Label runat="server" Text='<%# Eval("Headline") %>'></asp:Label>
                                </h2>
                            </a>
                            Offentliggjort
                    <asp:Label runat="server" Text='<%# Eval("DatePublished") %>'></asp:Label><br />
                            Af
                    <asp:Label runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                            <p class="u-margin-top-1">
                                <b>
                                    <asp:Label runat="server" Text='<%# Eval("Lede") %>'></asp:Label></b>
                            </p>
                            <p class="u-margin-top-1">
                                <asp:Label runat="server" Text='<%# Eval("BodyText") %>'></asp:Label>
                            </p>
                        </div>
                    </ItemTemplate>
                    <EmptyDataTemplate>
                        <p class="u-margin-bottom-2">Der er ingen nyheder i dit feed endnu. Gå ind på nogle kategorier og følg dem!</p>
                    </EmptyDataTemplate>
                </asp:ListView>
                <asp:Button ID="btnLoadMore" Visible="false" runat="server" CssClass="btn btn-primary u-margin-bottom-2" Text="Indlæs flere" OnClick="btnLoadMore_Click" />
            </div>
        </section>
        <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-4 o-page__col-lg-4">
            <KW:SideBar runat="server" />
        </section>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
</asp:Content>
