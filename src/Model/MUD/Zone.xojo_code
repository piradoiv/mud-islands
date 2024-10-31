#tag Class
Protected Class Zone
	#tag Method, Flags = &h0
		Shared Function FromJSON(input As JSONItem) As MUD.Zone
		  Var result As New MUD.Zone
		  result.Id = input.Lookup("id", "")
		  Select Case input.Lookup("type", "")
		  Case "pvp"
		    result.Type = Types.PVP
		  Case "pve"
		    result.Type = Types.PVE
		  End Select
		  
		  result.Name = input.Lookup("name", "Untitled")
		  
		  Var rooms As JSONItem = input.Lookup("rooms", New JSONItem)
		  For i As Integer = 0 To rooms.LastRowIndex
		    Var newRoom As MUD.Room = MUD.Room.FromJSON(rooms.ValueAt(i))
		    newRoom.Zone = result
		    result.Rooms.Add(newRoom)
		  Next
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveRoomAt(x As Integer, y As Integer, z As Integer)
		  For i As Integer = Rooms.LastIndex DownTo 0
		    Var r As Room = Rooms(i)
		    If r.X = x And r.Y = y And r.Z = z Then
		      Rooms.RemoveAt(i)
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToJSON() As JSONItem
		  Var result As New JSONItem
		  
		  result.Value("id") = Id
		  Var typeString As String
		  Select Case Type
		  Case Types.PVE
		    typeString = "pve"
		  Case Types.PVP
		    typeString = "pve"
		  End Select
		  result.Value("type") = typeString
		  
		  result.Value("name") = Name
		  
		  Var roomsItem As New JSONItem("[]")
		  For Each room As MUD.Room In Rooms
		    roomsItem.Add(room.ToJSON)
		  Next
		  result.Value("rooms") = roomsItem
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ZoneColor() As Color
		  Var zoneIndex As Integer = Island.Zones.IndexOf(Self)
		  
		  Var typeIndex As Integer = Integer(Self.Type)
		  Var hue As Double = Abs(Sin(0.6 + typeIndex))
		  Return Color.HSV(hue, 1, 1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ZRange() As Pair
		  Var minZ As Integer
		  Var maxZ As Integer
		  
		  For Each room As MUD.Room In Rooms
		    minZ = Min(minZ, room.Z)
		    maxZ = Max(maxZ, room.Z)
		  Next
		  
		  Return minZ : maxZ
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Id As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mIsland <> Nil And mIsland.Value <> Nil Then
			    Return MUD.Island(mIsland.Value)
			  End If
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mIsland = New WeakRef(value)
			End Set
		#tag EndSetter
		Island As MUD.Island
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mIsland As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h0
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Rooms() As MUD.Room
	#tag EndProperty

	#tag Property, Flags = &h0
		Type As MUD.Zone.Types = MUD.Zone.Types.Unknown
	#tag EndProperty


	#tag Enum, Name = Types, Type = Integer, Flags = &h0
		Unknown
		  PVP
		PVE
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Id"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Type"
			Visible=false
			Group="Behavior"
			InitialValue="MUD.Zone.Types.Unknown"
			Type="MUD.Zone.Types"
			EditorType="Enum"
			#tag EnumValues
				"0 - Unknown"
				"1 - PVP"
				"2 - PVE"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
