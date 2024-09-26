#tag Class
Protected Class Map
	#tag Method, Flags = &h0
		Shared Function FromJSON(input As JSONItem) As MUD.Map
		  // input = New JSONItem(kExampleInput)
		  
		  Var result As New MUD.Map
		  Var islands As JSONItem = input.Value("islands")
		  For i As Integer = 0 To islands.LastRowIndex
		    result.Islands.Add(MUD.Island.FromJSON(islands.ValueAt(i)))
		  Next
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToJSON() As JSONItem
		  Var result As New JSONItem
		  
		  Var islandsItem As New JSONItem
		  For Each island As MUD.Island In Islands
		    islandsItem.Add(island.ToJSON)
		  Next
		  
		  result.Value("islands") = islandsItem
		  
		  Return result
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Islands() As MUD.Island
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
	#tag EndViewBehavior
End Class
#tag EndClass
