object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 510
  ClientWidth = 733
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 733
    Height = 37
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 10
      Width = 43
      Height = 15
      Caption = 'API Key:'
    end
    object edApiKey: TEdit
      Left = 59
      Top = 7
      Width = 631
      Height = 23
      TabOrder = 0
      OnChange = edApiKeyChange
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 145
    Width = 733
    Height = 365
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    TabOrder = 1
    object Memo1: TMemo
      Left = 5
      Top = 5
      Width = 723
      Height = 355
      Align = alClient
      TabOrder = 0
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 37
    Width = 733
    Height = 108
    Align = alTop
    BevelOuter = bvNone
    BorderWidth = 5
    TabOrder = 2
    object PageControl1: TPageControl
      Left = 5
      Top = 5
      Width = 723
      Height = 98
      ActivePage = TabSheet3
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Queries'
        object Button1: TButton
          Left = 3
          Top = 3
          Width = 126
          Height = 25
          Caption = 'Get subscribers'
          TabOrder = 0
          OnClick = Button1Click
        end
        object btGetGroups: TButton
          Left = 135
          Top = 3
          Width = 126
          Height = 25
          Caption = 'Get groups'
          TabOrder = 1
          OnClick = btGetGroupsClick
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Add subscriber'
        ImageIndex = 1
        object Label2: TLabel
          Left = 4
          Top = 9
          Width = 35
          Height = 15
          Caption = 'Name:'
        end
        object Label3: TLabel
          Left = 251
          Top = 9
          Width = 32
          Height = 15
          Caption = 'Email:'
        end
        object edName: TEdit
          Left = 47
          Top = 6
          Width = 198
          Height = 23
          TabOrder = 0
          OnChange = edApiKeyChange
        end
        object edEmail: TEdit
          Left = 294
          Top = 6
          Width = 234
          Height = 23
          TabOrder = 1
          OnChange = edApiKeyChange
        end
        object btAddSusbcriber: TButton
          Left = 539
          Top = 5
          Width = 142
          Height = 25
          Caption = 'Add Subscriber'
          TabOrder = 2
          OnClick = btAddSusbcriberClick
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Add to group'
        ImageIndex = 2
        object Label4: TLabel
          Left = 3
          Top = 8
          Width = 36
          Height = 15
          Caption = 'Group:'
        end
        object Label5: TLabel
          Left = 250
          Top = 8
          Width = 32
          Height = 15
          Caption = 'Email:'
        end
        object edGroup: TEdit
          Left = 46
          Top = 5
          Width = 198
          Height = 23
          TabOrder = 0
          OnChange = edApiKeyChange
        end
        object edSubscriberToAdd: TEdit
          Left = 293
          Top = 5
          Width = 234
          Height = 23
          TabOrder = 1
          OnChange = edApiKeyChange
        end
        object btAddGroupSubscriber: TButton
          Left = 538
          Top = 4
          Width = 167
          Height = 25
          Caption = 'Add subscriber to group'
          TabOrder = 2
          OnClick = btAddGroupSubscriberClick
        end
      end
    end
  end
end
