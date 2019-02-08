<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DynamicCategory.aspx.cs" Inherits="DynamicCategory" MasterPageFile="~/MasterPage.master" %>

<%@ Register TagPrefix="KW" TagName="SideBar" Src="Sidebar.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <ol class="breadcrumb u-margin-left-1">
        <li><a href="/">KulturWatch</a></li>
        <li runat="server" id="liCategory" class="active"></li>
    </ol>
    <div class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-8 o-page__col-lg-8 u-margin-remove-top">
        <h1 class="pull-left">
            <asp:Label ID="lblName" runat="server" />
        </h1>
        <asp:PlaceHolder runat="server" ID="btnPlaceholder"></asp:PlaceHolder>
    </div>
    <!--     <div class="o-page__row">
 -->
    <div>
        <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-8 o-page__col-lg-8 u-remove-padding">
            <asp:ListView ID="lvNews1" runat="server">
                <ItemTemplate>
                    <div class="o-page__col-xs-12 o-page__col-sm-6 o-page__col-md-6 o-page__col-lg-6">
                        <a class="u-link-anonymous" href="/<%# Eval("CategoryURL") %>/<%# Eval("URL") %>.aspx">
                            <asp:Image ImageUrl='<%# Eval("ImagePath") %>' runat="server" />
                            <h2 class="h3">
                                <asp:Label runat="server" Text='<%# Eval("Headline") %>'></asp:Label></h2>
                            <p>
                                <asp:Label runat="server" Text='<%# Eval("Lede") %>'></asp:Label>
                            </p>
                        </a>
                    </div>
                </ItemTemplate>
                <EmptyDataTemplate>
                    <div class="o-page__col-xs-12 o-page__col-sm-6 o-page__col-md-6 o-page__col-lg-6">
                        <p class="u-margin-bottom-2">Der er ingen nyheder i denne kategori på nuværende tidspunkt.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:ListView>
            <div class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-12 o-page__col-lg-12 c-highlighted u-margin-top-3 u-margin-bottom-2">
                <asp:ListView ID="lvNews2" runat="server">
                    <ItemTemplate>
                        <div class="media">
                            <a class="u-link-anonymous" href="/<%# Eval("CategoryURL") %>/<%# Eval("URL") %>.aspx">
                                <div class="media-left o-page__col-xs-12 o-page__col-sm-6 o-page__col-md-6 o-page__col-lg-6">
                                    <asp:Image ImageUrl='<%# Eval("ImagePath") %>' runat="server" />
                                </div>
                                <div class="media-body o-page__col-xs-12 o-page__col-sm-6 o-page__col-md-6 o-page__col-lg-6">
                                    <h2 class="h3">
                                        <asp:Label runat="server" Text='<%# Eval("Headline") %>'></asp:Label></h2>
                                    <p>
                                        <asp:Label runat="server" Text='<%# Eval("Lede") %>'></asp:Label>
                                    </p>
                                </div>
                            </a>
                        </div>
                    </ItemTemplate>
                </asp:ListView>
            </div>
        </section>
        <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-4 o-page__col-lg-4">
            <KW:SideBar runat="server" />
        </section>
    </div>
</asp:Content>
