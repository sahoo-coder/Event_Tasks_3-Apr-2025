pageextension 50451 salesOrderPageEXT extends "Sales Order"
{
    layout
    {
        // Add changes to page layout here
        addafter("Sell-to Customer No.")
        {
            field(SO_HEADER_KSS; Rec.SO_HEADER_KSS)
            {
                Caption = 'So Header KSS';
                ApplicationArea = All;
                Editable = Rec.Status <> Rec.Status::Released;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}