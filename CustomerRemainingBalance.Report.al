/// <summary>
/// Report Customer Remaining Balance (ID 50081).
/// </summary>
Report 50081 "Customer Remaining Balance"
{
    UsageCategory = Lists;
    RDLCLayout = './Layouts/CustomerRemainingBalance.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            column(Customer_No; "Cust. Ledger Entry"."Customer No.")
            {
            }
            column(Customer_Name; CustName)
            {
            }
            column(Document_Type; "Cust. Ledger Entry"."Document Type")
            {
            }
            column(Posting_Date; "Cust. Ledger Entry"."Posting Date")
            {
            }
            column(Close_Date; "Cust. Ledger Entry"."Closed at Date")
            {
            }
            column(Remaining_Amt; "Cust. Ledger Entry"."Remaining Amount")
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
                SetRange("Closed at Date", StartDate, EndDate);
                SetFilter("Remaining Amount", '=%1', 0);
            end;

            trigger OnAfterGetRecord();
            begin
                CustRec.Reset;
                CustRec.SetRange(CustRec."No.", "Cust. Ledger Entry"."Customer No.");
                if CustRec.FindFirst then
                    CustName := CustRec.Name;
                Diff := "Cust. Ledger Entry"."Closed at Date" - "Cust. Ledger Entry"."Posting Date";
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
                group(Options)
                {
                    Caption = 'Options';

                }
            }
        }

        actions
        {
        }
    }

    trigger OnInitReport()
    begin
        EndDate := Today;

    end;


    var
        Month: Integer;
        Year: Integer;
        CustName: Text;
        EndDate: Date;
        TMnth: Integer;
        TYear: Integer;
        TDay: Integer;
        StartDate: Date;
        CustRec: Record Customer;
        Diff: Decimal;


}
