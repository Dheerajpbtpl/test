/// <summary>
/// Report Check GSTR (ID 50300).
/// </summary>
Report 50300 "Check GSTR"
{
    RDLCLayout = './Layouts/CheckGSTR.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Integer; Integer)
        {
            trigger OnPreDataItem();
            begin
                SetRange(Number, 1, 1);
            end;

            trigger OnAfterGetRecord();
            begin
                /*
				NettAmount1:=0;
				SalesInvHeader.RESET;
				SalesInvHeader.SETRANGE("Posting Date",StartDate,EndDate);
				IF SalesInvHeader.FINDFIRST THEN REPEAT
				  SalesInvHeader.CALCFIELDS("Amount to Customer");
				  NettAmount1:=NettAmount1+SalesInvHeader."Amount to Customer";
				UNTIL SalesInvHeader.NEXT=0;
				//MESSAGE(FORMAT(NettAmount1));
				SalesCrMemoHeader.RESET;
				SalesCrMemoHeader.SETRANGE("Posting Date",StartDate,EndDate);
				IF SalesCrMemoHeader.FINDFIRST THEN REPEAT
				  SalesCrMemoHeader.CALCFIELDS("Amount to Customer");
				  NettAmount2:=NettAmount2+SalesCrMemoHeader."Amount to Customer";
				UNTIL SalesCrMemoHeader.NEXT=0;
				//MESSAGE(FORMAT(NettAmount2));
				//MESSAGE(FORMAT(SalesInvHeader.COUNT));
				//MESSAGE(FORMAT(SalesCrMemoHeader.COUNT));
				//MESSAGE(FORMAT(SalesInvHeader.COUNT+SalesCrMemoHeader.COUNT));
				DetGstLedEntry.RESET;
				DetGstLedEntry.SETRANGE("Posting Date",StartDate,EndDate);
				DetGstLedEntry.SETRANGE("Transaction Type",DetGstLedEntry."Transaction Type"::Sales);
				DetGstLedEntry.CALCSUMS("GST Base Amount","GST Amount");
				MESSAGE(FORMAT(DetGstLedEntry."GST Base Amount"));
				MESSAGE(FORMAT(DetGstLedEntry."GST Amount"));
				*/
                SalesInvLine.Reset;
                SalesInvLine.SetRange("Posting Date", StartDate, EndDate);
                // SalesInvLine.CalcSums(Amount, "GST Base Amount", "Amount Including Tax", "Line Amount", "Amount To Customer");
                SalesInvLine.CalcSums(Amount, "Amount Including VAT", "Line Amount");
                Message(Format(SalesInvLine.Amount));
                // Message(Format(SalesInvLine."GST Base Amount"));
                Message(Format(SalesInvLine."Amount Including VAT"));
                Message(Format(SalesInvLine."Line Amount"));
                // Message(Format(SalesInvLine."Amount To Customer"));

            end;

        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                field("Start Date"; StartDate)
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; EndDate)
                {
                    ApplicationArea = Basic;
                }

            }
        }

        actions
        {
        }
    }



    var
        SalesInvLine: Record "Sales Invoice Line";
        PurcInvLine: Record "Purch. Inv. Line";
        ILE: Record "Item Ledger Entry";
        DetGstLedEntry: Record "Detailed GST Ledger Entry";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        StartDate: Date;
        EndDate: Date;
        NettAmount1: Decimal;
        NettAmount2: Decimal;


}
