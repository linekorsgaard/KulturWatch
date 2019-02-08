<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" MasterPageFile="~/MasterPage.master" %>

<%@ Register TagPrefix="KW" TagName="SideBar" Src="Sidebar.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <section class="modal fade" id="introModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <button id="introModalClose" class="close" data-dismiss="modal" data-target="#introModal">×</button>
                    <h1 class="modal-title">Velkommen til</h1>
                    <img src="/img/logo.png" alt="KulturWatch" class="img-responsive" />
                    <div id="carousel" class="carousel slide u-margin-bottom-2" data-ride="carousel">
                        <div class="carousel-inner u-margin-top-3" role="listbox">
                            <div class="item active text-center">
                                <img src="/img/intro-1.jpg" alt="Dit nye kulturmedie eksempel">
                                <h2 class="u-padding-left-1 u-padding-right-1 u-padding-top-1 u-margin-remove-top">Dit nye kulturmedie, der fornyer måden, hvorpå du læser nyheder!</h2>
                                <p class="u-margin-remove-top">Se hvordan ved at gennemgå denne introduktion</p>
                            </div>
                            <div class="item text-center">
                                <img src="/img/intro-2.jpg" alt="Du opretter din bruger eksempel">
                                <h2 class="u-padding-left-1 u-padding-right-1 u-padding-top-1 u-margin-remove-top">Du opretter din bruger og kan nu følge de kategorier, der passer dig</h2>
                                <p class="u-margin-remove-top">Se dem i "Mit feed"</p>
                            </div>
                            <div class="item text-center">
                                <img src="/img/intro-4.jpg" alt="Begivenheder eksempel">
                                <h2 class="u-padding-left-1 u-padding-right-1 u-padding-top-1 u-margin-remove-top">Du får adgang til eksklusive begivenheder og oven i købet rabat</h2>
                                <p class="u-margin-remove-top">Vi samarbejder med flere virksomheder om at stille dit kulturbehov</p>
                            </div>
                            <div class="item text-center">
                                <img src="/img/intro-3.jpg" alt="Artikler til offline læsning eksempel">
                                <h2 class="u-padding-left-1 u-padding-right-1 u-padding-top-1 u-margin-remove-top">Gem artikler til offline læsning, så du altid har læsestof</h2>
                                <p class="u-margin-remove-top">KulturWatch svigter ikke, når du rejser eller udsættes for ustabil forbindelse</p>
                            </div>
                            <div class="item text-center">
                                <img src="/img/intro-5.jpg" alt="Kulturven for livet">
                                <h2 class="u-padding-left-1 u-padding-right-1 u-padding-top-1 u-margin-remove-top">Vi er din kulturven for livet</h2>
                                <p class="u-margin-remove">
                                    Og prøveperioden er ganske gratis! <a href="/Signup.aspx">Opret dig <i class="fa fa-angle-right"></i></a>
                                    <br />
                                    <a data-dismiss="modal" data-target="#introModal" class="btn btn-primary u-margin-top-1">Afslut</a>
                                </p>
                            </div>
                        </div>
                        <a class="left carousel-control" href="#carousel" role="button" data-slide="prev">
                            <span class="fa fa-angle-left" aria-hidden="true"></span>
                            <span class="sr-only">Forrige</span>
                        </a>
                        <a class="right carousel-control" href="#carousel" role="button" data-slide="next">
                            <span class="fa fa-angle-right" aria-hidden="true"></span>
                            <span class="sr-only">Næste</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="c-highlighted clearfix u-margin-bottom-1">
        <div class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-8 o-page__col-lg-8 u-remove-padding">
            <a id="linkTopNews1" runat="server" href="">
                <asp:Image ID="imgTopNews1" AlternateText="Nyhed" runat="server" />
            </a>
        </div>
        <div class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-4 o-page__col-lg-4">
            <a id="linkTopNews" runat="server">
                <h2 class="h1">
                    <asp:Label ID="lblTopNews1Heading" runat="server" Text=""></asp:Label></h2>
            </a>
            <p>
                <asp:Label ID="lblTopNews1Lede" runat="server" Text=""></asp:Label>
            </p>
            <h3 class="h4">Relaterede artikler</h3>
            <asp:ListView ID="lvRelated" runat="server">
                <LayoutTemplate>
                    <ul class="o-list">
                        <li runat="server" id="itemPlaceholder" />
                    </ul>
                </LayoutTemplate>
                <ItemTemplate>
                    <li><a href="/<%# Eval("CategoryURL") %>/<%# Eval("URL") %>.aspx"><%# Eval("Headline") %></a></li>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </section>
    <div class="o-page__row">
        <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-8 o-page__col-lg-8">
            <asp:ListView ID="lvTopNews" runat="server">
                <ItemTemplate>
                    <div class="o-page__col-xs-12 o-page__col-sm-6 o-page__col-md-6 o-page__col-lg-6 u-margin-bottom-1 u-margin-top-1">
                        <a class="u-link-anonymous" href="/<%# Eval("CategoryURL") %>/<%# Eval("URL") %>.aspx">
                            <asp:Image ImageUrl='<%# Eval("ImagePath") %>' AlternateText="Nyhed" runat="server" />
                            <h2 class="h3">
                                <asp:Label runat="server" Text='<%# Eval("Headline") %>'></asp:Label></h2>
                            <p>
                                <asp:Label runat="server" Text='<%# Eval("Lede") %>'></asp:Label>
                            </p>
                        </a>
                        <a href='/<%# Eval("CategoryURL") %>'>
                            <asp:Label runat="server" Text='<%# Eval("CategoryName") %>'></asp:Label></a>
                    </div>
                </ItemTemplate>
            </asp:ListView>
            <asp:PlaceHolder ID="phLatest" Visible="false" runat="server">
                <div class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-12 o-page__col-lg-12 c-highlighted u-margin-top-2 u-margin-bottom-2">
                    <h2>Seneste nyt om <a id="linkLatest" runat="server">
                        <asp:Label ID="lblLatestHeadline" runat="server" Text="Label"></asp:Label></a></h2>
                    <div>
                        <asp:ListView ID="lvLatestCategory" runat="server">
                            <ItemTemplate>
                                <div class="media">
                                    <a class="u-link-anonymous" href="/<%# Eval("CategoryURL") %>/<%# Eval("URL") %>.aspx">
                                        <div class="media-left o-page__col-xs-12 o-page__col-sm-6 o-page__col-md-6 o-page__col-lg-6 u-remove-padding">
                                            <asp:Image ImageUrl='<%# Eval("ImagePath") %>' AlternateText="Nyhed" runat="server" />
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
                            <EmptyDataTemplate>
                                <p class="u-margin-bottom-2">Der er ingen nyheder i denne kategori endnu.</p>
                            </EmptyDataTemplate>
                        </asp:ListView>
                    </div>
                </div>
            </asp:PlaceHolder>
        </section>
        <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-4 o-page__col-lg-4 u-margin-top-1">
            <KW:SideBar runat="server" />
        </section>
    </div>
</asp:Content>
