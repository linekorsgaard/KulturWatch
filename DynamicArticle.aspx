<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DynamicArticle.aspx.cs" Inherits="DynamicArticle" MasterPageFile="~/MasterPage.master" %>

<%@ Register TagPrefix="KW" TagName="SideBar" Src="Sidebar.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <ol class="breadcrumb u-margin-left-1">
        <li><a href="/">KulturWatch</a></li>
        <li><a runat="server" id="linkCategory"></a></li>
        <li class="active" runat="server" id="liArticle"></li>
    </ol>
    <article itemscope itemtype="http://schema.org/NewsArticle">
        <div class="c-highlighted clearfix u-margin-bottom-1">
            <div class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-8 o-page__col-lg-8 u-remove-padding">
                <asp:Image ID="imgImage" runat="server" />
            </div>
            <div class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-4 o-page__col-lg-4 u-margin-top-1">
                Offentliggjort <time itemprop="datePublished">
            <asp:Label ID="lblDate" Text="" runat="server" /></time><br />
                Af
            <asp:Label ID="lblAuthor" itemprop="author" Text="" runat="server" />
                <p class="u-margin-top-1">
                    <strong>
                        <asp:Label ID="lblLede" itemprop="description" Text="" runat="server" />
                    </strong>
                </p>
                <button runat="server" visible="false" type="button" id="btnSaveArticle" class="btn btn-primary u-margin-top-1"><i class="fa fa-save u-margin-right-half"></i>Gem artikel</button>
                <p class="u-margin-top-1">
                    <a id="linkFB" runat="server" title="Del på Facebook">
                        <i class="fa fa-facebook fa-2x u-margin-right-half"></i>
                    </a>
                    <a id="linkTW" runat="server" title="Del på Twitter">
                        <i class="fa fa-twitter fa-2x u-margin-right-half"></i>
                    </a>
                    <a id="linkEmail" runat="server" title="Del via e-mail">
                        <i class="fa fa-envelope fa-2x u-margin-right-half"></i>
                    </a>
                    <a href="javascript:window.print()" title="Print denne side">
                        <i class="fa fa-print fa-2x"></i>
                    </a>
                </p>
            </div>
        </div>
        <asp:Label ID="lblArticleID" runat="server" CssClass="u-hidden"></asp:Label>
        <div class="o-page__row">
            <div class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-8 o-page__col-lg-8">
                <h2 class="h1" itemprop="headline">
                    <asp:Label ID="lblHeadline" Text="" runat="server" />
                </h2>
                <asp:Label ID="lblBodyText" itemprop="articleBody" Text="" runat="server" />
                <asp:PlaceHolder ID="phLocked" Visible="false" runat="server">
                    <div class="well text-center u-margin-top-2">
                        <h3 class="u-margin-remove-top">Denne artikel er låst!</h3>
                        <p><a href="/Login.aspx" class="btn btn-primary">Log ind for at læse artiklen</a></p>
                        <p>eller <a href="/Signup.aspx">opret dig</a></p>
                    </div>
                </asp:PlaceHolder>
                <h3 class="u-margin-top-2">Relaterede artikler</h3>
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
                <div class="c-highlighted u-padding-1 u-margin-top-2 u-margin-bottom-2">
                    <h2 class="h3 u-margin-top-half">Kommentarer</h2>
                    <asp:TextBox ID="txtComment" Visible="false" CssClass="form-control" runat="server" TextMode="MultiLine"></asp:TextBox>
                    <asp:Button ID="btnComment" Visible="false" CssClass="btn btn-default u-margin-top-1" runat="server" Text="Send kommentar" OnClick="btnComment_Click" />
                    <asp:Label ID="lblCommentMsg" Text="<i>Du skal være logget ind for at skrive kommentarer</i>" runat="server" />
                    <asp:ListView ID="lvComments" runat="server">
                        <ItemTemplate>
                            <div class="clearfix u-margin-top-2">
                                <p class="pull-left"><b><%# Eval("Name") %></b></p>
                                <p class="pull-right"><b><%# Eval("DateCreated") %></b></p>
                            </div>
                            <p><%# Eval("Comment") %></p>
                        </ItemTemplate>
                    </asp:ListView>
                    <asp:ListView ID="lvCommentsAdmin" Visible="false" runat="server">
                        <ItemTemplate>
                            <div class="clearfix u-margin-top-2">
                                <p class="pull-left"><b><%# Eval("Name") %></b></p>
                                <p class="pull-right"><b><%# Eval("DateCreated") %></b></p>
                            </div>
                            <p><%# Eval("Comment") %></p>
                            <asp:Button runat="server" class="btn btn-danger" Text="Slet kommentar" OnClientClick="if(!confirm('Er du sikker på, at du vil slette denne kommentar?')) return false;" CommandArgument='<%# Eval("CommentID") %>' OnClick="deleteComment" />
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            <p class="u-margin-bottom-2">Der er ingen kommentarer endnu. Du kan blive den første!</p>
                        </EmptyDataTemplate>
                    </asp:ListView>
                </div>
            </div>
            <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-4 o-page__col-lg-4">
                <KW:SideBar runat="server" />
            </section>
        </div>
    </article>
</asp:Content>
