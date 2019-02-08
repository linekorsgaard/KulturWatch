<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MyProfile.aspx.cs" Inherits="MyProfile" MasterPageFile="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <ol class="breadcrumb u-margin-left-1">
        <li><a href="/">KulturWatch</a></li>
        <li class="active">Mine oplysninger</li>
    </ol>
    <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-12 o-page__col-lg-12">
        <h1>Mine oplysninger</h1>
        <p>Her har du mulighed for at se og opdatere dine oplysninger.
            <br />
            Hvis du ønsker at opsige dit abonnement, kontakt da Esben på <a href="mailto:esben@infowatch.dk">esben@infowatch.dk</a>.</p>
        <h2 class="h3">Abonnementsstatus</h2>
        <p>
            Abonnenent - prøveperiode <br />
            Næste betaling d. <strong>              
            <asp:Label ID="lblDate" runat="server" Text=""></asp:Label></strong>
        </p>
        <p>Du vil modtage en e-mail med instruktioner til betaling, når datoen er nået.</p>
        <h2 class="h3">Rediger oplysninger</h2>
    </section>
    <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-6 o-page__col-lg-4 c-highlighted u-margin-bottom-2 u-margin-top-1 u-padding-remove-left-right u-padding-top-bottom-1 u-margin-left-1">
        <div class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-12 o-page__col-lg-12">
            <div class="form-group">
                <label for="txtName" class="col-sm-2 control-label">Navn</label>
                <asp:TextBox ID="txtName" CssClass="form-control" runat="server"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="txtAddress" class="col-sm-2 control-label">Adresse</label>
                <asp:TextBox ID="txtAddress" CssClass="form-control" runat="server"></asp:TextBox>
            </div>
            <label for="txtZip" class="control-label">Postnr. og by</label>
        </div>
        <div class="o-page__col-xs-4 o-page__col-sm-4 o-page__col-md-10 o-page__col-lg-12">
            <asp:TextBox ID="txtZip" TextMode="Number" CssClass="form-control" runat="server"></asp:TextBox>
        </div>
        <div class="o-page__col-xs-8 o-page__col-sm-8 o-page__col-md-10 o-page__col-lg-12">
            <asp:TextBox ID="txtCity" CssClass="form-control" runat="server"></asp:TextBox>
        </div>
        <div class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-12 o-page__col-lg-12">
            <hr />
            <div class="form-group">
                <label for="txtTelephone" class="col-sm-2 control-label">Telefon</label>
                <asp:TextBox ID="txtTelephone" CssClass="form-control" runat="server"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="txtEmail" class="control-label">E-mail</label>
                <asp:TextBox ID="txtEmail" TextMode="Email" CssClass="form-control" runat="server"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Button ID="btnSave" CssClass="btn btn-primary" runat="server" Text="Gem oplysninger" OnClick="btnSave_Click" />
            </div>
        </div>
    </section>
</asp:Content>
