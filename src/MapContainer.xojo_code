#tag WebContainerControl
Begin WebContainer MapContainer
   Compatibility   =   ""
   ControlCount    =   0
   ControlID       =   ""
   CSSClasses      =   ""
   Enabled         =   True
   Height          =   250
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
   Width           =   250
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mPanelIndex    =   -1
   Begin WebCanvas MapCanvas
      ControlID       =   ""
      CSSClasses      =   ""
      DiffEngineDisabled=   False
      Enabled         =   True
      Height          =   250
      Index           =   -2147483648
      Indicator       =   0
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Visible         =   True
      Width           =   250
      _mPanelIndex    =   -1
   End
End
#tag EndWebContainerControl

#tag WindowCode
	#tag Event
		Sub Opening()
		  Refresh
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  Refresh
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub CreateIsland(name As String)
		  Var newIsland As New MUD.Island 
		  newIsland.Id = name.Lowercase.ReplaceAll(" ", "-")
		  newIsland.Name = name
		  Session.Map.Islands.Add(newIsland)
		  Refresh
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub IslandPressedHandler(sender As MapIslandContainer)
		  RaiseEvent Pressed(sender)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MapRadius() As Integer
		  Return 300
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Refresh()
		  For Each island As MapIslandContainer In mIslands
		    island.Close
		  Next
		  mIslands.RemoveAll
		  
		  Const PI = 3.14159265
		  Var PI2 As Double = PI * 2
		  Var HalfPi As Double = PI / 2
		  
		  Var center As New Point(Session.ClientWidth / 2, Session.ClientHeight / 2)
		  
		  Var amount As Integer = Session.Map.Islands.Count
		  Var degPerIsland As Double = PI2 / amount
		  
		  Var positions() As Point
		  
		  Var r As Integer = MapRadius
		  For i As Integer = 0 To amount - 1
		    Var deg As Double = i * degPerIsland
		    Var x As Integer = (r * Cos(deg)) + center.X
		    Var y As Integer = (r * Sin(deg)) + center.Y
		    positions.Add(New Point(x, y))
		  Next
		  
		  For i As Integer = 0 To positions.LastIndex
		    Var position As Point = positions(i)
		    Var newIsland As New MapIslandContainer
		    AddHandler newIsland.Pressed, WeakAddressOf IslandPressedHandler
		    Var size As Integer = 130 + 10 * (Session.Map.Islands(i).RoomCount - 1)
		    newIsland.Width = size
		    newIsland.Height = size
		    newIsland.Island = Session.Map.Islands(i)
		    newIsland.EmbedWithin(Self, position.X - newIsland.Width / 2, position.Y - newIsland.Height / 2, newIsland.Width, newIsland.Height)
		    mIslands.Add(newIsland)
		  Next
		  
		  MapCanvas.Refresh
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Pressed(container As MapIslandContainer)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mIslands() As MapIslandContainer
	#tag EndProperty

	#tag Property, Flags = &h0
		mPositions() As Point
	#tag EndProperty


#tag EndWindowCode

#tag Events MapCanvas
	#tag Event
		Sub Paint(g As WebGraphics)
		  Const PI = 3.14159265
		  Const d = 30
		  Var PI2 As Double = PI * 2
		  Var HalfPi As Double = PI / 2
		  
		  Var center As New Point(g.Width / 2, g.Height / 2)
		  
		  Var amount As Integer = Session.Map.Islands.Count
		  Var degPerIsland As Double = PI2 / amount
		  
		  Var positions() As Point
		  
		  Var r As Integer = MapRadius
		  For i As Integer = 0 To amount - 1
		    Var deg As Double = i * degPerIsland
		    Var x As Integer = (r * Cos(deg)) + (g.Width / 2)
		    Var y As Integer = (r * Sin(deg)) + (g.Height / 2)
		    positions.Add(New Point(x, y))
		  Next
		  
		  g.DrawingColor = RectangleBorderColorGroup
		  For i As Integer = 0 To positions.LastIndex
		    Var position As Point = positions(i)
		    
		    Var connections() As String = Session.Map.Islands(i).ConnectedTo
		    For Each connection As String In connections
		      For connectionIndex As Integer = 0 To Session.Map.Islands.LastIndex
		        If Session.Map.Islands(connectionIndex).Id = connection And connectionIndex > i Then
		          Var fromPoint As Point = positions(i)
		          Var toPoint As Point = positions(connectionIndex)
		          g.PenSize = 2
		          g.DrawLine(fromPoint.X, fromPoint.Y, toPoint.X, toPoint.Y)
		          g.PenSize = 1
		        End If
		      Next
		    Next
		    
		    // g.DrawingColor = Color.Red
		    // g.FillOval(position.X - d/2, position.Y - d/2, d, d)
		    // g.DrawingColor = Color.Black
		    // g.PenSize = 2
		    // g.DrawOval(position.X - d/2, position.Y - d/2, d, d)
		    // g.PenSize = 1
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.Style.Opacity = 0
		End Sub
	#tag EndEvent
	#tag Event
		Sub Shown()
		  Me.Style.AddTransition("opacity", .25, WebStyle.SpeedPatterns.EaseInOut, 1)
		  Me.Style.Opacity = 100
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
#tag EndViewBehavior
