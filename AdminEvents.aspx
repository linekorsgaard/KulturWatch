<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminEvents.aspx.cs" Inherits="AdminEvents" MasterPageFile="~/MasterPage.master" enableEventValidation="false" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <section class="o-page__col-xs-12 o-page__col-sm-12 o-page__col-md-12 o-page__col-lg-12">
        <h1>Administrer begivenheder</h1>
        <a href="#ovEvents">Gå til oversigt over alle begivenheder</a>
        <h2>Opret ny</h2>
        <div class="form-group">
            <label for="txtEventName" class="control-label">Titel</label>
            <asp:TextBox ID="txtEventName" CssClass="form-control" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ValidationGroup="events" ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEventName" ErrorMessage="Titel er påkrævet" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <label for="txtEventDescription" class="control-label">Beskrivelse</label>
            <asp:TextBox ID="txtEventDescription" TextMode="MultiLine" CssClass="form-control" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ValidationGroup="events" ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEventDescription" ErrorMessage="Beskrivelse er påkrævet" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <label for="txtEventStart" class="control-label">Startdato</label>
            <asp:TextBox ID="txtEventStart" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ValidationGroup="events" ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtEventStart" ErrorMessage="Startdato er påkrævet" ForeColor="Red"></asp:RequiredFieldValidator><br />
            <asp:CompareValidator ValidationGroup="events" ID="CompareValidator1" runat="server" ControlToValidate="txtEventStart" ErrorMessage="Dato skal være i dag eller i fremtiden." ForeColor="Red" Operator="GreaterThanEqual" Type="Date"></asp:CompareValidator>
        </div>
        <div class="form-group">
            <label for="txtEventEnd" class="control-label">Slutdato</label>
            <asp:TextBox ID="txtEventEnd" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ValidationGroup="events" ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtEventEnd" ErrorMessage="Slutdato er påkrævet" ForeColor="Red"></asp:RequiredFieldValidator><br />
            <asp:CompareValidator ValidationGroup="events" ID="CompareValidator2" runat="server" ControlToValidate="txtEventEnd" ErrorMessage="Dato skal være i dag eller i fremtiden." ForeColor="Red" Operator="GreaterThanEqual" Type="Date"></asp:CompareValidator>
        </div>
        <div class="form-group">
            <label for="txtPrice" class="control-label">Normalpris for begivenheden (voksen)</label>
            <asp:TextBox ID="txtPrice" CssClass="form-control" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ValidationGroup="events" ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtPrice" ErrorMessage="Pris er påkrævet" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <label for="txtReducedPrice" class="control-label">Reduceret pris for KulturWatch's medlemmer</label>
            <p>Lad feltet stå tomt, hvis ingen rabat</p>
            <asp:TextBox ID="txtReducedPrice" CssClass="form-control" runat="server"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Button ID="btnNewEvent" ValidationGroup="events" CssClass="btn btn-default" runat="server" Text="Opret begivenhed" OnClick="btnNewEvent_Click" />
        </div>
        <h2 id="ovEvents">Alle begivenheder</h2>
        <div class="table-responsive">
            <asp:listview id="lvEvents" runat="server">
                <LayoutTemplate>
                    <table class="table">
                        <tr>
                            <th>Titel</th>
                            <th>Beskrivelse</th>
                            <th>Dato start</th>
                            <th>Dato slut</th>
                            <th>Pris</th>
                            <th>Reduceret pris</th>
                            <th>Status</th>
                            <th></th>
                            <th></th>
                        </tr>
                        <tr runat="server" id="itemPlaceholder" />
                    </table>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <asp:Label ID="lblName" runat="server" Text='<%# Eval("EventName") %>' />
                        </td>
                        <td>
                            <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>' />
                        </td>
                        <td>
                            <asp:Label ID="lblDateStart" runat="server" Text='<%# Eval("DateStart") %>' />
                        </td>
                        <td>
                            <asp:Label ID="lblDateEnd" runat="server" Text='<%# Eval("DateEnd") %>' />
                        </td>
                        <td>
                            <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("Price") %>' />
                        </td>
                        <td>
                            <asp:Label ID="lblReducedPrice" runat="server" Text='<%# Eval("ReducedPrice") %>' />
                        </td>
                        <td>
                            <asp:Label ID="lblEventStatus" runat="server" Text='<%# Eval("Name") %>' />
                        </td>
                        <td>
                            <asp:Button runat="server" class="btn" Text="Godkend begivenhed" Visible='<%# Int32.Parse(Eval("FK_EventStatus").ToString()) == 1 ? true : false %>' CommandArgument='<%# Eval("EventID") %>' OnClick="approveEvent" />
                            <asp:Button runat="server" class="btn btn-danger" Text="Afvis begivenhed" Visible='<%# Int32.Parse(Eval("FK_EventStatus").ToString()) == 1 ? true : false %>' OnClientClick="if(!confirm('Er du sikker på, at du vil afvise denne begivenhed?')) return false;" CommandArgument='<%# Eval("EventID") %>' OnClick="declineEvent" />
                        </td>
                        <td>
                            <asp:Button runat="server" class="btn btn-danger" Text="Slet" OnClientClick="if(!confirm('Er du sikker på, at du vil slette denne begivenhed?')) return false;" CommandArgument='<%# Eval("EventID") %>' OnClick="deleteEvent" />
                        </td>
                    </tr>
                </ItemTemplate>
                <EmptyDataTemplate>
                    <p class="u-margin-bottom-2">Der er ingen events på nuværende tidspunkt.</p>
                </EmptyDataTemplate>
            </asp:listview>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="Server">
    <script src="https://cloud.tinymce.com/stable/tinymce.min.js"></script>
    <script>tinymce.init({ selector: 'textarea' });</script>
</asp:Content>
