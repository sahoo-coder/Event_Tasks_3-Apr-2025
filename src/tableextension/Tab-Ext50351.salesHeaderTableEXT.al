tableextension 50351 salesHeaderTableEXT extends "Sales Header"
{
    fields
    {
        // Add changes to table fields here
        field(50900; SO_HEADER_KSS; Text[100])
        {
            Caption = 'Sales Header_KSS';
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}