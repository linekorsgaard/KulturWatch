<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DynamicPage.aspx.cs" Inherits="DynamicPage" MasterPageFile="~/MasterPage.master" %>

<%@ Register TagPrefix="KW" TagName="SideBar" Src="Sidebar.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <ol class="breadcrumb u-margin-left-1">
        <li><a href="/">KulturWatch</a></li>
        <li runat="server" id="liPage" class="active"></li>
    </ol>
    <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-8 o-page__col-lg-8 u-remove-padding">
        <asp:Image ID="imgPage" runat="server" />
        <h1>
            <asp:Label ID="lblTitle" runat="server" />
        </h1>
        <asp:Label ID="lblContent" runat="server" />
        <asp:Panel ID="plAbout" runat="server" Visible="false">
            <h2>Her er vi</h2>
            <div class="media">
                <div class="media-left o-page__col-xs-12 o-page__col-sm-4 o-page__col-md-4 o-page__col-lg-4 u-remove-padding">
                    <img src="/img/soeren.jpg" alt="Søren Larsen" />
                </div>
                <div class="media-body o-page__col-xs-12 o-page__col-sm-8 o-page__col-md-8 o-page__col-lg-8">
                    <h3 class="u-margin-remove-top">Søren Larsen</h3>
                    <p>Søren, født 1980, er uddannet journalist fra Journalisthøjskolen i Aarhus og bachelor i engelsk og litteraturvidenskab. Han har før arbejdet som freelance-journalist og som journalist og redaktør på BT. </p>
                    <p>E-mail: <a href="mailto:soeren@kulturwatch.dk">soeren@kulturwatch.dk</a><br />
                        Tlf: <a href="tel:00000001">00 00 00 01</a>
                    </p>
                </div>
            </div>
            <div class="media">
                <div class="media-left o-page__col-xs-12 o-page__col-sm-4 o-page__col-md-4 o-page__col-lg-4 u-remove-padding">
                    <img src="/img/ida.jpg" alt="Ida Mito" />
                </div>
                <div class="media-body o-page__col-xs-12 o-page__col-sm-8 o-page__col-md-8 o-page__col-lg-8">
                    <h3 class="u-margin-remove-top">Ida Mito</h3>
                    <p>Ida, født 1982, er uddannet journalist fra Danmarks Journalisthøjskole i 2008 og cand.public. i journalistik samt international politik og økonomi fra Syddansk Universitet. </p>
                    <p>E-mail: <a href="mailto:ida@kulturwatch.dk">ida@kulturwatch.dk</a><br />
                        Tlf: <a href="tel:00000002">00 00 00 02</a>
                    </p>
                </div>
            </div>
            <div class="media">
                <div class="media-left o-page__col-xs-12 o-page__col-sm-4 o-page__col-md-4 o-page__col-lg-4 u-remove-padding">
                    <img src="/img/anders.jpg" alt="Anders Agger" />
                </div>
                <div class="media-body o-page__col-xs-12 o-page__col-sm-8 o-page__col-md-8 o-page__col-lg-8">
                    <h3 class="u-margin-remove-top">Anders Agger</h3>
                    <p>Anders, født 1987, er uddannet journalist fra Syddansk Universitet i Odense i 2014 og har en kandidatgrad i Business Administration and Information Systems fra CBS.</p>
                    <p>E-mail: <a href="mailto:agger@kulturwatch.dk">anders@kulturwatch.dk</a><br />
                        Tlf: <a href="tel:00000003">00 00 00 03</a>
                    </p>
                </div>
            </div>
            <div class="media">
                <div class="media-left o-page__col-xs-12 o-page__col-sm-4 o-page__col-md-4 o-page__col-lg-4 u-remove-padding">
                    <img src="/img/jacob.jpg" alt="Jacob Andersen" />
                </div>
                <div class="media-body o-page__col-xs-12 o-page__col-sm-8 o-page__col-md-8 o-page__col-lg-8">
                    <h3 class="u-margin-remove-top">Jacob Andersen</h3>
                    <p>Jacob, født 1980, er uddannet cand.comm. i journalistik fra Roskilde Universitet i 2006 med praktiktid hos Fyens Stiftstidende. Han har desuden en bachelor i Kultur- og Sprogmødestudier.</p>
                    <p>E-mail: <a href="mailto:jacob@kulturwatch.dk">jacob@kulturwatch.dk</a><br />
                        Tlf: <a href="tel:00000004">00 00 00 04</a>
                    </p>
                </div>
            </div>
            <div class="media u-margin-bottom-2">
                <div class="media-left o-page__col-xs-12 o-page__col-sm-4 o-page__col-md-4 o-page__col-lg-4 u-remove-padding">
                    <img src="/img/sara.jpg" alt="Sara Berg" />
                </div>
                <div class="media-body o-page__col-xs-12 o-page__col-sm-8 o-page__col-md-8 o-page__col-lg-8">
                    <h3 class="u-margin-remove-top">Sara Berg</h3>
                    <p>Sara, født 1988, er uddannet journalist ved Danmarks Medie- og Journalisthøjskole i Aarhus i 2014 og cand.public. fra Aarhus Universitet. </p>
                    <p>E-mail: <a href="mailto:sara@kulturwatch.dk">sara@kulturwatch.dk</a><br />
                        Tlf: <a href="tel:00000005">00 00 00 05</a>
                    </p>
                </div>
            </div>
        </asp:Panel>
    </section>
    <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-4 o-page__col-lg-4">
        <KW:SideBar runat="server" />
    </section>
</asp:Content>
