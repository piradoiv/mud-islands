#tag WebContainerControl
Begin WebContainer IslandRoomContainer
   Compatibility   =   ""
   ControlCount    =   0
   ControlID       =   ""
   CSSClasses      =   ""
   Enabled         =   True
   Height          =   150
   Indicator       =   0
   LayoutDirection =   0
   LayoutType      =   0
   Left            =   0
   LockBottom      =   False
   LockHorizontal  =   False
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   LockVertical    =   False
   PanelIndex      =   0
   ScrollDirection =   0
   TabIndex        =   0
   Top             =   0
   Visible         =   True
   Width           =   150
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mPanelIndex    =   -1
   Begin WebRectangle BackgroundRectangle
      BackgroundColor =   &cFFFFFF
      BorderColor     =   &c00000000
      BorderThickness =   2
      ControlCount    =   0
      ControlID       =   ""
      CornerSize      =   -1
      CSSClasses      =   ""
      Enabled         =   True
      HasBackgroundColor=   True
      Height          =   150
      Index           =   -2147483648
      Indicator       =   ""
      LayoutDirection =   "LayoutDirections.LeftToRight"
      LayoutType      =   "LayoutTypes.Fixed"
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Visible         =   True
      Width           =   150
      _mDesignHeight  =   0
      _mDesignWidth   =   0
      _mPanelIndex    =   -1
      Begin WebImageViewer LadderImageViewer
         ControlID       =   ""
         CSSClasses      =   ""
         DisplayMode     =   1
         Enabled         =   True
         Height          =   18
         Image           =   0
         Index           =   -2147483648
         Indicator       =   ""
         Left            =   66
         LockBottom      =   True
         LockedInPosition=   False
         LockHorizontal  =   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         LockVertical    =   False
         PanelIndex      =   0
         Parent          =   "BackgroundRectangle"
         Scope           =   2
         SVGData         =   ""
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   91
         URL             =   ""
         Visible         =   True
         Width           =   18
         _mPanelIndex    =   -1
         _ProtectImage   =   False
      End
      Begin WebRectangle ZoneRectangle
         BackgroundColor =   &cFFFFFF
         BorderColor     =   &c000000FF
         BorderThickness =   0
         ControlCount    =   0
         ControlID       =   ""
         CornerSize      =   100
         CSSClasses      =   ""
         Enabled         =   True
         HasBackgroundColor=   True
         Height          =   10
         Index           =   -2147483648
         Indicator       =   ""
         LayoutDirection =   "LayoutDirections.LeftToRight"
         LayoutType      =   "LayoutTypes.Fixed"
         Left            =   70
         LockBottom      =   False
         LockedInPosition=   False
         LockHorizontal  =   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         LockVertical    =   False
         PanelIndex      =   0
         Parent          =   "BackgroundRectangle"
         Scope           =   2
         TabIndex        =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   42
         Visible         =   True
         Width           =   10
         _mDesignHeight  =   0
         _mDesignWidth   =   0
         _mPanelIndex    =   -1
      End
      Begin WebLabel CaptionLabel
         Bold            =   False
         ControlID       =   ""
         CSSClasses      =   ""
         Enabled         =   True
         FontName        =   ""
         FontSize        =   0.0
         Height          =   150
         Index           =   -2147483648
         Indicator       =   ""
         Italic          =   False
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockHorizontal  =   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         LockVertical    =   False
         Multiline       =   False
         PanelIndex      =   0
         Parent          =   "BackgroundRectangle"
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Untitled"
         TextAlignment   =   2
         TextColor       =   &c000000FF
         Tooltip         =   ""
         Top             =   0
         Underline       =   False
         Visible         =   True
         Width           =   150
         _mPanelIndex    =   -1
      End
   End
End
#tag EndWebContainerControl

#tag WindowCode
	#tag Method, Flags = &h0
		Sub Refresh()
		  CaptionLabel.Text = room.Name + EndOfLine + "(" + room.X.ToString + ", " + room.Y.ToString + ", " + room.Z.ToString + ")"
		  
		  ZoneRectangle.BackgroundColor = room.Zone.ZoneColor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetBorders(north As Boolean, south As Boolean, east As Boolean, west As Boolean)
		  If north Then
		    BackgroundRectangle.Style.Value("border-top-style") = "none"
		    BackgroundRectangle.Style.Value("border-top-left-radius") = "0"
		    BackgroundRectangle.Style.Value("border-top-right-radius") = "0"
		  End If
		  
		  If south Then
		    BackgroundRectangle.Style.Value("border-bottom-style") = "none"
		    BackgroundRectangle.Style.Value("border-bottom-left-radius") = "0"
		    BackgroundRectangle.Style.Value("border-bottom-right-radius") = "0"
		  End If
		  
		  If east Then
		    BackgroundRectangle.Style.Value("border-right-style") = "none"
		    BackgroundRectangle.Style.Value("border-top-right-radius") = "0"
		    BackgroundRectangle.Style.Value("border-bottom-right-radius") = "0"
		  End If
		  
		  If west Then
		    BackgroundRectangle.Style.Value("border-left-style") = "none"
		    BackgroundRectangle.Style.Value("border-top-left-radius") = "0"
		    BackgroundRectangle.Style.Value("border-bottom-left-radius") = "0"
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Pressed()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return LadderImageViewer.Visible
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If LadderImage = Nil Then
			    LadderImage = WebPicture.BootstrapIcon("ladder", Color.LightGray)
			    LadderImage.Session = Nil
			  End If
			  
			  LadderImageViewer.Visible = value
			  LadderImageViewer.URL = LadderImage.URL
			End Set
		#tag EndSetter
		HasLadder As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Shared LadderImage As WebPicture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRoom As MUD.Room
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mRoom
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRoom = value
			  Refresh
			End Set
		#tag EndSetter
		Room As MUD.Room
	#tag EndComputedProperty


#tag EndWindowCode

#tag Events CaptionLabel
	#tag Event
		Sub Pressed()
		  RaiseEvent Pressed
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.Style.Cursor = WebStyle.Cursors.Pointer
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="PanelIndex"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mPanelIndex"
		Visible=false
		Group="Behavior"
		InitialValue="-1"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ControlCount"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ControlID"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockHorizontal"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockVertical"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mDesignHeight"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mDesignWidth"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mName"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ScrollDirection"
		Visible=true
		Group="Behavior"
		InitialValue="ScrollDirections.None"
		Type="WebContainer.ScrollDirections"
		EditorType="Enum"
		#tag EnumValues
			"0 - None"
			"1 - Horizontal"
			"2 - Vertical"
			"3 - Both"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Visual Controls"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Indicator"
		Visible=false
		Group="Visual Controls"
		InitialValue=""
		Type="WebUIControl.Indicators"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Primary"
			"2 - Secondary"
			"3 - Success"
			"4 - Danger"
			"5 - Warning"
			"6 - Info"
			"7 - Light"
			"8 - Dark"
			"9 - Link"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="LayoutType"
		Visible=true
		Group="View"
		InitialValue="LayoutTypes.Fixed"
		Type="LayoutTypes"
		EditorType="Enum"
		#tag EnumValues
			"0 - Fixed"
			"1 - Flex"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="LayoutDirection"
		Visible=true
		Group="View"
		InitialValue="LayoutDirections.LeftToRight"
		Type="LayoutDirections"
		EditorType="Enum"
		#tag EnumValues
			"0 - LeftToRight"
			"1 - RightToLeft"
			"2 - TopToBottom"
			"3 - BottomToTop"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=false
		Group=""
		InitialValue="250"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=false
		Group=""
		InitialValue="250"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasLadder"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
