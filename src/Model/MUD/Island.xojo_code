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
		    result.Zones.Add(MUD.Zone.FromJSON(zones.ValueAt(i)))
		  Next
		  
		  Return result
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
		Function ToJSON() As JSONItem
		  Var result As New JSONItem
		  
		  result.Value("id") = Id
		  result.Value("name") = Name
		  
		  Var zonesItem As New JSONItem
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
