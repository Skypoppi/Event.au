//
//  FillEventDetailView.swift
//  Events.au
//
//  Created by Austin Xu on 2023/12/20.
//

import SwiftUI
import AVFoundation

struct FillEventDetailView: View {
    @State var options = ["Education", "Entertainment", "Networking", "Design"]
    @State private var eventTitle = ""
    @State private var category = ""
    @State private var venue = ""
    @State private var participants = 0
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var startTime = Date()
    @State private var endTime = Date()
    @State private var desc = ""
    @State private var showDatePicker = false
    @State private var shouldNavigate = false
            
    var limitRange: ClosedRange<Date>{
        let oneMonthAgo = Calendar.current.date(byAdding: .month, value: -1, to: Date())
        let twoMonthFromNow = Calendar.current.date(byAdding: .month,value: 2, to: Date())
        return oneMonthAgo!...twoMonthFromNow!
    }
    
    var body: some View {
        VStack{
            // Event Title
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("text_color_grey"))
                .fill(.white)
                .overlay(
                    HStack(alignment: .center){
                        TextField("Event Title", text:$eventTitle)
                    }.padding()
                ).frame(width: 300, height: 50)

            
            // Category
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("text_color_grey"))
                .fill(.white)
                .overlay(
                    HStack(alignment: .center){
                        TextField("Category", text:$category)
                        Spacer()
                        Menu{
                            ForEach(options, id:\.self){item in
                                Button {
                                    category = item
                                } label: {
                                    Text(item)
                                }
                            }
                        }label: {
                            Image(systemName: "arrowtriangle.down.fill")
                                .foregroundColor(.black)
                        }
                    }.padding()
                ).frame(width: 300, height: 50)

            
            // Venue
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("text_color_grey"))
                .fill(.white)
                .overlay(
                    HStack(alignment: .center){
                        TextField("Venue", text:$venue)
                        
                    }.padding()
                ).frame(width: 300, height: 50)

            
            // Number of Participants
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("text_color_grey"))
                .fill(.white)
                .overlay(
                    HStack(alignment: .center){
                        Stepper(participants == 0 ? "Number of Participants": "\(participants)", value:$participants)
                    }.padding()
                ).frame(width: 300, height: 50)

            // Start Date & End Date
//                HStack(alignment: .center){
//
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(Color("text_color_grey"))
//                        .fill(.white)
//                        .frame(height: 50)
//                        .overlay {
//                            HStack{
//                                if showDatePicker == false{
//                                    Text("Start Date:")
//                                    Spacer()
//                                    Image(systemName: "calendar")
//                                        .onTapGesture {
//                                            self.showDatePicker.toggle()
//                                        }
//                                }
//                                else{
//                                    DatePicker("Start Date", selection: $startDate, displayedComponents: [.date])
//                                        .labelsHidden()
//                                }
//                            }.padding()
//                        }
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(Color("text_color_grey"))
//                        .fill(.white)
//                        .frame(height: 50)
//                        .overlay {
//                            DatePicker("End Date", selection: $startDate, displayedComponents: [.date])
//                                .labelsHidden()
//                        }
//                }.frame(width: 300) // End of HStack
            
            
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("text_color_grey"))
                .fill(.white)
                .overlay {
                    DatePicker("Start Date", selection: $startDate, in:limitRange,displayedComponents: [.date])
                        .padding()
                }.frame(width: 300, height: 50)

            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("text_color_grey"))
                .fill(.white)
                .overlay {
                    DatePicker("End Date", selection: $endDate, in: limitRange,displayedComponents: [.date])
                        .padding()
                }.frame(width: 300, height: 50)

            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("text_color_grey"))
                .fill(.white)
                .overlay {
                    DatePicker("Start Time", selection: $startTime, in:limitRange,displayedComponents: [.hourAndMinute])
                        .padding()
                }.frame(width: 300, height: 50)

            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("text_color_grey"))
                .fill(.white)
                .overlay {
                    DatePicker("End Time", selection: $endTime, in:limitRange,displayedComponents: [.hourAndMinute])
                        .padding()
                }.frame(width: 300, height: 50)
            
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("text_color_grey"))
                .fill(.white)
                .overlay {
                    VStack {
                        TextField("Description", text:$desc, axis: .vertical)
                            .lineLimit(4)
                        Spacer()
                    }.padding()
                }.frame(width: 300, height: 130)
                
            NavigationLink(destination: PendingEventView(), isActive: $shouldNavigate) {
                Button {
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd-MM-yyyy"
                    let timeFormatter = DateFormatter()
                    timeFormatter.dateFormat = "HH:mm"
                    
                    // add action here
                    print(eventTitle, category, venue, participants, dateFormatter.string(from: startDate), dateFormatter.string(from: endDate),timeFormatter.string(from: startTime),timeFormatter.string(from: endTime),desc)
                    self.shouldNavigate.toggle()
                } label: {
                    RoundedRectangle(cornerRadius: 50)
                        .fill(
                            LinearGradient(
                                colors: [Color("red_primary"),
                                         Color("red_secondary")],
                                startPoint: .top,
                                endPoint: .bottom)
                        )
                        .frame(width: 300, height: 50)
                        .overlay(
                            Text("Host an Event")
                                .foregroundColor(.white)
                            , alignment: .center
                        )
                }

            }
        }
        .navigationTitle("Fill Event Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        
    }
}



#Preview {
    FillEventDetailView()
}

