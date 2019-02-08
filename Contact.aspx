<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Contact.aspx.cs" Inherits="Contact" MasterPageFile="~/MasterPage.master" %>

<%@ Register TagPrefix="KW" TagName="SideBar" Src="Sidebar.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <ol class="breadcrumb u-margin-left-1">
        <li><a href="/">KulturWatch</a></li>
        <li class="active">Kontakt</li>
    </ol>
    <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-8 o-page__col-lg-8 u-remove-padding">
        <h1>Kontakt</h1>
        <h2 class="h3">Adresse</h2>
        KulturWatch<br />
        St. Regnegade 12, 2. sal<br />
        1110 København K<br />
        Tlf.: <a href="">00 00 00 01</a>

        <h2 class="h3">Annoncering og salg</h2>

        <h3 class="h4">Abonnement</h3>
        Mikael Justesen<br />
        <a href="">mikael@infowatch.dk</a><br />
        Tlf: <a href="">70 77 74 42</a>

        <h3 class="h4">Annoncering</h3>
        Esben Albertsen<br />
        <a href="">esben@infowatch.dk</a><br />
        Tlf: <a href="">71 71 74 22</a>
        <h2 class="h3">Abonnement</h2>
        <a href="">mikael@infowatch.dk</a><br />
        <a href="">Tlf.: 7077 7442</a>

        <h2>Bogholderi</h2>
        <p>
            Ved henvendelser vedr. fakturakopi, levering af faktura, betalingsfrister mv., kontakt <a href="mailto:debitor.watch@jppol.dk">debitor.watch@jppol.dk</a><br />
            Har du spørgsmål til selve ydelsen på din faktura, bedes du kontakte ITWatch:
        </p>
        <p>
            <a href="mailto:kulturwatch@infowatch.dk">kulturwatch@infowatch.dk</a><br />
            Tlf.: <a href="tel:00000001">00 00 00 01</a>
        </p>
    </section>
    <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-4 o-page__col-lg-4">
        <KW:SideBar runat="server" />
    </section>
</asp:Content>
