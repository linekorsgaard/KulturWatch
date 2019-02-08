<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SignUp.aspx.cs" Inherits="Signup" MasterPageFile="~/MasterPage.master" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-12 o-page__col-lg-12">
        <h1>Opret bruger</h1>
        <p>
            Med din bruger på KulturWatch har du muligheden for at logge ind og få adgang til vores mange funktioner.
            <br />
            Har du problemer med at oprette dig, kontakt da Esben på <a href="mailto:esben@infowatch.dk">esben@infowatch.dk</a>.
        </p>
        <p>
            Har du allerede en bruger? <a href="/Login.aspx">Log ind <i class="fa fa-angle-right"></i></a>
        </p>
        
            <asp:Label ID="lblSuccess" Visible="false" Text="<p class='u-margin-top-1 alert alert-success' role='alert'>Du er nu oprettet! <a href='/Login.aspx'>Log ind <i class='fa fa-angle-right'></i></p>" runat="server" />
    </section>
    <asp:Panel ID="plSignup" Visible="true" runat="server">
        <section class="oo-page__col-xs-12 o-page__col-sm-12 o-page__col-md-6 o-page__col-lg-4 o-page__col-lg-offset-4 o-page__col-md-offset-3 c-highlighted u-margin-bottom-2 u-margin-top-1 u-padding-remove-left-right u-padding-top-bottom-1">
            <div class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-12 o-page__col-lg-12">
                <div class="form-group">
                    <label for="txtName" class="control-label">Navn</label>
                        <asp:TextBox ID="txtName" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName" ErrorMessage="Navn er påkrævet." ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <label for="txtAddress" class="control-label">Adresse</label>
                        <asp:TextBox ID="txtAddress" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtAddress" ErrorMessage="Adresse er påkrævet." ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                <label for="txtZip" class="control-label">Postnr. og by</label>
            </div>
            <div class="o-page__col-xs-12 o-page__col-sm-10 o-page__col-md-4 o-page__col-lg-4">
                <asp:TextBox ID="txtZip" TextMode="Number" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtZip" ErrorMessage="Postnr. er påkrævet." ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="o-page__col-xs-12 o-page__col-sm-10 o-page__col-md-8 o-page__col-lg-8">
                <asp:TextBox ID="txtCity" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtCity" ErrorMessage="By er påkrævet." ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="o-page__col-lg-12 o-page__col-md-12 o-page__col-sm-12 o-page__col-xs-12">
                <hr />
                <div class="form-group">
                    <label for="txtTelephone" class="control-label">Telefon</label>
                        <asp:TextBox ID="txtTelephone" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtTelephone" ErrorMessage="Telefon er påkrævet." ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <label for="txtEmail" class="control-label">E-mailadresse</label>
                        <asp:TextBox ID="txtEmail" TextMode="Email" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtEmail" ErrorMessage="E-mailadresse er påkrævet." ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <label for="txtPassword" class="control-label">Kodeord</label>
                        <asp:TextBox ID="txtPassword" TextMode="Password" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtPassword" ErrorMessage="Kodeord er påkrævet." ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <label for="txtPassword2" class="control-label">Gentag kodeord</label>
                        <asp:TextBox ID="txtPassword2" TextMode="Password" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtPassWord2" ErrorMessage="Bekræftelse af kodeord er påkrævet." ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="checkbox">
                    <label>
                        <asp:CheckBox ID="chkAccept" runat="server" />
                        Jeg accepterer <a href="/service/Abonnementsvilkaar.pdf" target="_blank">betingelserne</a>
                    </label>
                    <p class="u-margin-top-1 text-danger">
                        <asp:Label ID="lblError" Text="" runat="server" /></p>
                </div>
                <div class="form-group">
                    <asp:Button ID="btnSignUp" CssClass="btn btn-primary" runat="server" Text="Opret" OnClick="btnSignUp_Click" />
                </div>
            </div>
        </section>
    </asp:Panel>
</asp:Content>
