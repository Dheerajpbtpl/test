Report 50085 "Posted date for Shipment"
{
    Permissions = TableData "Item Ledger Entry" = rimd,
                  TableData "Sales Shipment Header" = rimd,
                  TableData "Sales Shipment Line" = rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = where("Document No." = filter('02-12-0614-103'));

            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = field("Document No.");


                trigger OnAfterGetRecord()
                begin
                    "Sales Shipment Line"."Posting Date" := 20140630D;
                    Modify;
                end;
            }
            dataitem("Sales Shipment Header"; "Sales Shipment Header")
            {
                DataItemLink = "No." = field("Document No.");


                trigger OnAfterGetRecord()
                begin
                    "Sales Shipment Header"."Posting Date" := 20140630D;
                    Modify;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                "Item Ledger Entry"."Posting Date" := 20140630D;
                Modify;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
}

