<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CommissionForm.aspx.cs" Inherits="ArtistsWebBilling.CommissionForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Artist tracks commission</title>
</head>
<body>
    <form id="commissionform" runat="server">
    <div>
    
    </div>
        <asp:SqlDataSource ID="dsCommission" runat="server" ConnectionString="<%$ ConnectionStrings:RVLDBConnection %>" SelectCommand="sp_GetArtistCommission" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="" Name="ArtistID" SessionField="ArtistID" Type="Int32" />
                <asp:SessionParameter DefaultValue="" Name="PeriodStart" SessionField="PeriodStart" Type="DateTime" />
                <asp:SessionParameter DefaultValue="" Name="PeriodEnd" SessionField="PeriodEnd" Type="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
    
        <asp:Label ID="lArtist" runat="server" Font-Bold="True" Font-Italic="True" Font-Overline="False" Font-Size="X-Large" Font-Underline="True" ForeColor="#6600CC" Text="Label"></asp:Label>
    
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" DataSourceID="dsCommission" GridLines="None" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="Track" HeaderText="Track" SortExpression="Track" />
                <asp:BoundField DataField="PlaybackCount" HeaderText="Playbacks" SortExpression="PlaybackCount" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="CommissionalPlaybackCount" HeaderText="Commissional playbacks" SortExpression="CommissionalPlaybackCount" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Commission" HeaderText="Commission" SortExpression="Commission" DataFormatString="{0:f2}" >
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="AmountBonusKoef" HeaderText="Bonus for amount" SortExpression="AmountBonusKoef">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="Total" DataFormatString="{0:f2}" HeaderText="Total" SortExpression="Total">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
            </Columns>
            <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
            <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
            <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
            <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#594B9C" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#33276A" />
        </asp:GridView>
    </form>
</body>
</html>
