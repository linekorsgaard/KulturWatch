<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" MasterPageFile="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-12 o-page__col-lg-12">
        <h1>Log ind</h1>
        <p>
            Med din bruger på KulturWatch har du muligheden for at logge ind og få adgang til vores mange funktioner.
            <br />
            Har du problemer med at logge ind, kontakt da Esben på <a href="mailto:esben@infowatch.dk">esben@infowatch.dk</a>.
        </p>
        <p>
            Ingen bruger? <a href="/Signup.aspx">Opret dig <i class="fa fa-angle-right"></i></a>
        </p>
    </section>
    <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-6 o-page__col-lg-4 o-page__col-lg-offset-4 o-page__col-md-offset-3 c-highlighted u-padding-1 u-margin-bottom-2 u-margin-top-1">
        <div class="form-group">
            <label for="txtEmail" class="col-sm-2 control-label">E-mail</label>
            <asp:TextBox ID="txtEmail" TextMode="Email" CssClass="form-control" runat="server"></asp:TextBox>
        </div>
        <div class="form-group">
            <label for="txtPassword" class="col-sm-2 control-label">Kodeord</label>
            <asp:TextBox ID="txtPassword" TextMode="Password" CssClass="form-control" runat="server"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Button ID="btnLogin" CssClass="btn btn-default" runat="server" Text="Log ind" OnClick="btnLogin_Click" />
        </div>
        <div class="has-error">
            <asp:Label ID="lblError" runat="server" Text="" CssClass="control-label"></asp:Label>
        </div>
    </section>
</asp:Content>
