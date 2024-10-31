#tag Class
Protected Class Island
	#tag Method, Flags = &h0
		Function ConnectedTo() As String()
		  Var result() As String
		  Var ids As New Set
		  
		  For Each zone As MUD.Zone In Zones
		    For Each room As MUD.Room In zone.Rooms
		      If room.IsBoatLocation Then
		        For Each connectedIsland As MUD.Entity In room.ConnectedIslands
		          ids.Add(connectedIsland.Id)
		        Next
		      End If
		    Next
		  Next
		  
		  For Each id As Variant In ids
		    result.Add(id.StringValue)
		  Next
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromJSON(input As JSONItem) As MUD.Island
		  Var result As New MUD.Island
		  
		  result.Id = input.Lookup("id", "")
		  result.Name = input.Lookup("name", "Untitled")
		  
		  Var zones As JSONItem = input.Lookup("zones", New JSONItem)
		  For i As Integer = 0 To zones.LastRowIndex
		    Var newZone As MUD.Zone = MUD.Zone.FromJSON(zones.ValueAt(i))
		    newZone.Island = result
		    result.Zones.Add(newZone)
		  Next
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetZoneFromId(id As String) As MUD.Zone
		  For Each zone As MUD.Zone In Zones
		    If zone.Id = id Then
		      Return zone
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MoveRoomToZone(room As MUD.Room, newZoneId As String)
		  Var oldZone As MUD.Zone = room.Zone
		  Var newZone As MUD.Zone = GetZoneFromId(newZoneId)
		  
		  For i As Integer = oldZone.Rooms.LastIndex DownTo 0
		    Var oldRoom As MUD.Room = oldZone.Rooms(i)
		    If oldRoom.X = room.X And oldRoom.Y = room.Y And oldRoom.Z = room.Z Then
		      oldZone.Rooms.RemoveAt(i)
		      Exit For
		    End If
		  Next
		  
		  For i As Integer = 0 To newZone.Rooms.LastIndex
		    Var newZoneRoom As MUD.Room = newZone.Rooms(i)
		    If newZoneRoom.X = room.X And newZoneRoom.Y = room.Y And newZoneRoom.Z = room.Z Then
		      Return
		    End If
		  Next
		  
		  newZone.Rooms.Add(room)
		  room.Zone = newZone
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RoomAt(x As Integer, y As Integer, z As Integer) As MUD.Room
		  For Each zone As MUD.Zone In Zones
		    For Each room As MUD.Room In Zone.Rooms
		      If room.X = x And room.Y = y And room.Z = z Then
		        Return room
		      End If
		    Next
		  Next
		  
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RoomCount() As Integer
		  Var result As Integer
		  
		  For Each zone As MUD.Zone In Zones
		    result = result + zone.Rooms.Count
		  Next
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RoomExists(x As Integer, y As Integer, z As Integer) As Boolean
		  Return RoomAt(x, y, z) <> Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RoomHasLadders(x As Integer, y As Integer, z As Integer) As Boolean
		  For Each zone As MUD.Zone In Zones
		    For Each room As MUD.Room In zone.Rooms
		      If room.X = x And room.Y = y And (room.Z = z - 1 Or room.Z = z + 1) Then
		        Return True
		      End If
		    Next
		  Next
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToJSON() As JSONItem
		  Var result As New JSONItem
		  
		  result.Value("id") = Id
		  result.Value("name") = Name
		  
		  Var zonesItem As New JSONItem("[]")
		  For Each zone As MUD.Zone In Zones
		    zonesItem.Add(zone.ToJSON)
		  Next
		  result.Value("zones") = zonesItem
		  
		  Return result
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Id As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Zones() As MUD.Zone
	#tag EndProperty


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
	#tag EndViewBehavior
End Class
#tag EndClass
