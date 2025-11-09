/// <summary>
/// Report PDC Deposit Cheques (ID 50005).
/// </summary>
Report 50005 "PDC Deposit Cheques"
{
    ProcessingOnly = true;
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem("Deposit Cheques"; "Deposit Cheques")
        {
            DataItemTableView = sorting("Cheque Type") order(ascending);

        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Deposit Cheques")
                {
                    Caption = 'Deposit Cheques';
                    field(PDCDate; PDCDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'PDC Date';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        "Deposit Cheques".GetCheques(PDCDate);
        //PAGE.RUN(PAGE::"Deposit Cheques");
    end;

    var
        PDCDate: Date;
        frmForm2: Page "Deposit Cheques";
}

