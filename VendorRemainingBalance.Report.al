Report 50082 "Vendor Remaining Balance"
{
    UsageCategory = Lists;
    RDLCLayout = './Layouts/VendorRemainingBalance.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            column(Vendor_No; "Vendor Ledger Entry"."Vendor No.")
            {
            }
            column(Vendor_Name; VendorName)
            {
            }
            column(Document_Type; "Vendor Ledger Entry"."Document Type")
            {
            }
            column(Posting_Date; "Vendor Ledger Entry"."Posting Date")
            {
            }
            column(Close_Date; "Vendor Ledger Entry"."Closed at Date")
            {
            }
            column(Remaining_Amt; "Vendor Ledger Entry"."Remaining Amount")
            {
            }
            column(Days; Diff)
            {
            }
            trigger OnPreDataItem();
            begin
                Month := Date2dmy(EndDate, 2);
                Year := Date2dmy(EndDate, 3);
                if Year <> 0 then begin
                    if Month >= 6 then begin
                        TMnth := Month - 6 + 1;
                        TYear := Year;
                        TDay := 1;
                    end else begin
                        TMnth := 12 - (6 - Month);
                        TYear := Year - 1;
                        TDay := 1;
                    end;
                    StartDate := Dmy2date(TDay, TMnth, TYear);
                end;
                SetRange("Document Type", "document type"::Invoice);
                SetFilter("Remaining Amount", '=%1', 0);
                SetRange("Closed at Date", StartDate, EndDate);
            end;

            trigger OnAfterGetRecord();
            begin
                VendorRec.Reset;
                VendorRec.SetRange(VendorRec."No.", "Vendor No.");
                if VendorRec.FindFirst then
                    VendorName := VendorRec.Name;
                Diff := "Closed at Date" - "Posting Date";
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
        Month: Integer;
        Year: Integer;
        VendorName: Text;
        EndDate: Date;
        TMnth: Integer;
        TYear: Integer;
        TDay: Integer;
        StartDate: Date;
        VendorRec: Record Vendor;
        Diff: Decimal;


}
