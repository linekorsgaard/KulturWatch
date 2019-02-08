<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Sidebar.ascx.cs" Inherits="Sidebar" %>
<h1 class="hidden">Sidebar</h1>

<a href="Signup.aspx">
    <img src="/img/kw-trial.jpg" alt="Prøv KulturWatch gratis i 14 dage" />
</a>
<section class="c-highlighted u-padding-1 u-margin-top-1">
    <asp:ListView ID="lvLatestNews" runat="server">
        <LayoutTemplate>
            <h2 class="h3 u-margin-remove-top">Seneste nyt</h2>
            <ul class="o-list">
                <li runat="server" id="itemPlaceholder" />
            </ul>
        </LayoutTemplate>
        <ItemTemplate>
            <li><a href="/<%# Eval("CategoryURL") %>/<%# Eval("URL") %>.aspx"><%# Eval("Headline") %></a></li>
        </ItemTemplate>
    </asp:ListView>
</section>
<section class="u-padding-1">
    <h2 class="h3 u-margin-top-half">Kommende begivenheder</h2>
    <asp:ListView ID="lvEvents" runat="server">
        <LayoutTemplate>
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
                    <a href="/event/<%# Eval("URL") %>"><%# Eval("EventName") %></a>
                    <p class="u-margin-top-half"><b>Pris: <%# Eval("Price") %> DKK</b></p>
                    <p class="u-margin-top-half">Medlemspris: <%# Eval("ReducedPrice") %> DKK</p>
                </div>
            </div>
        </ItemTemplate>
        <EmptyDataTemplate>
            <p class="u-margin-bottom-2">Der er ingen begivenheder i den nærmeste fremtid.</p>
        </EmptyDataTemplate>

    </asp:ListView>
</section>
