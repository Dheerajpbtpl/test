/// <summary>
/// Report Customer Detail Trail Balance2 (ID 50045).
/// </summary>
Report 50045 "Customer Detail Trail Balance2"
{
    RDLCLayout = './Layouts/CustomerDetailTrailBalance2.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = sorting("Customer No.", "Posting Date") order(ascending);
            RequestFilterFields = "Customer No.", "Posting Date";
            column(CustomerNo; "Cust. Ledger Entry"."Customer No.")
            {
            }
            column(PostingDate_CustLedgerEntry; Format("Cust. Ledger Entry"."Posting Date"))
            {
            }
            column(DocumentType_CustLedgerEntry; "Cust. Ledger Entry"."Document Type")
            {
            }
            column(DocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."Document No.")
            {
            }
            column(RemainingAmount_CustLedgerEntry; "Cust. Ledger Entry"."Remaining Amount")
            {
            }
            column(DebitAmount_CustLedgerEntry; "Cust. Ledger Entry"."Debit Amount")
            {
            }
            column(CreditAmount_CustLedgerEntry; "Cust. Ledger Entry"."Credit Amount")
            {
            }
            column(CustName; CustomerRec.Name)
            {
            }
            column(AllFilter; AllFilter)
            {
            }
            column(AllFilters; AllFilters)
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("Document No."), "Sell-to Customer No." = field("Customer No.");
                DataItemLinkReference = "Cust. Ledger Entry";
                RequestFilterFields = "Posting Date";
                column(No_SalesInvoiceLine; "Sales Invoice Line"."No.")
                {
                }
                column(Description_SalesInvoiceLine; "Sales Invoice Line".Description)
                {
                }
                column(Quantity_SalesInvoiceLine; "Sales Invoice Line".Quantity)
                {
                }
                column(UnitPrice_SalesInvoiceLine; "Sales Invoice Line"."Unit Price")
                {
                }
                column(AmountIncludingVAT_SalesInvoiceLine; AmountIncludingVAT_SalesInvoiceLine)
                {
                }
                column(PrintDetail; PrintDetail)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    AmountIncludingVAT_SalesInvoiceLine := 0;
                    CustLedEntry.Reset();
                    CustLedEntry.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                    CustLedEntry.CalcFields(Amount);
                    AmountIncludingVAT_SalesInvoiceLine := CustLedEntry.amount;

                end;
            }
            trigger OnPreDataItem();
            begin
                AllFilter := GetFilter("Posting Date");
                AllFilters := GetFilters;
            end;

            trigger OnAfterGetRecord();
            begin
                CustomerRec.Get("Cust. Ledger Entry"."Customer No.");
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
                group("Print Details")
                {
                    field("Print Detail"; PrintDetail)
                    {
                        ApplicationArea = Basic;
                    }

                }
            }
        }

        actions
        {
        }
    }

    trigger OnInitReport()
    begin
        PrintDetail := true;


    end;


    var
        AmountIncludingVAT_SalesInvoiceLine: Decimal;
        CustLedEntry: Record "Cust. Ledger Entry";

        PrintDetail: Boolean;
        CustomerRec: Record Customer;
        AllFilter: Text;
        AllFilters: Text;


}
