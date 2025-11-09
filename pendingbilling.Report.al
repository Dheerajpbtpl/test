Report 50199 "pending billing"
{
    UsageCategory = Lists;
    RDLCLayout = './Layouts/pendingbilling.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            RequestFilterFields = "Sell-to Customer No.", "Posting Date";
            column(SelltoCustomerNo_SalesLine; "Sales Line"."Sell-to Customer No.")
            {
            }
            column(DocumentNo_SalesLine; "Sales Line"."Document No.")
            {
            }
            column(Description_SalesLine; "Sales Line".Description)
            {
            }
            column(Quantity_SalesLine; "Sales Line".Quantity)
            {
            }
            column(UnitPrice_SalesLine; "Sales Line"."Unit Price")
            {
            }
            column(Amount_SalesLine; "Sales Line".Amount)
            {
            }
            column(getfilters; "Sales Line".GetFilters)
            {
            }
            column(Name_CompanyInformation; CompanyInformation.Name)
            {
            }
            column(comment; Comm)
            {
            }
            trigger OnAfterGetRecord();
            begin
                Comm := '';
                SalesCommentLine.Reset;
                SalesCommentLine.SetRange("Document Type", "Document Type");
                SalesCommentLine.SetRange("No.", "Document No.");
                if SalesCommentLine.FindFirst then
                    Comm := SalesCommentLine.Comment;
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



    trigger OnPreReport()
    begin
        CompanyInformation.Get;

    end;

    var
        filters: Text;
        CompanyInformation: Record "Company Information";
        SalesCommentLine: Record "Sales Comment Line";
        Comm: Text;


}
