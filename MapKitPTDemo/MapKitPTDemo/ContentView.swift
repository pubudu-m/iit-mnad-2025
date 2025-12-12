//
//  ContentView.swift
//  MapKitPTDemo
//
//  Created by Pubudu Mihiranga on 2025-11-22.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let cameraPosition: MapCameraPosition = .region(.init(
        center: .init(latitude: 37.3346, longitude: -122.0090),
        latitudinalMeters: 1500,
        longitudinalMeters: 1500))
    
    let appleParkVisitorCenter = CLLocationCoordinate2D(latitude: 37.332753,
                                                        longitude: -122.005372)
    let panamaPark = CLLocationCoordinate2D(latitude: 37.347730,
                                            longitude: -122.018715)
    
    @State private var lookAroundView: MKLookAroundScene?
    @State private var showLookAroundView = false
    
    @State private var route: MKRoute?
    
    let locationManager = CLLocationManager()
    
    var body: some View {
        Map(initialPosition: cameraPosition) {
            Annotation("Apple Park Visitor Center", coordinate: appleParkVisitorCenter, anchor: .bottom) {
                Image(systemName: "laptopcomputer")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.white)
                    .frame(width: 20, height: 20)
                    .padding(7)
                    .background(.red.gradient, in: .circle)
                    .contextMenu {
                        Button("Open look around", systemImage: "binoculars") {
                            Task {
                                lookAroundView = await getLookAroundView(coordinate: appleParkVisitorCenter)
                                if lookAroundView != nil {
                                    showLookAroundView = true
                                }
                            }
                        }
                        
                        Button("Get directions", systemImage: "arrow.turn.down.right") {
                            getDirections(destination: appleParkVisitorCenter)
                        }
                    }
            }
            
            Annotation("Panama Park", coordinate: panamaPark, anchor: .bottom) {
                Image(systemName: "tree.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.white)
                    .frame(width: 20, height: 20)
                    .padding(7)
                    .background(.red.gradient, in: .circle)
                    .contextMenu {
                        Button("Open look around", systemImage: "binoculars") {
                            Task {
                                lookAroundView = await getLookAroundView(coordinate: panamaPark)
                                if lookAroundView != nil {
                                    showLookAroundView = true
                                }
                            }
                        }
                        
                        Button("Get directions", systemImage: "arrow.turn.down.right") {
                            getDirections(destination: panamaPark)
                        }
                    }
            }
            
            UserAnnotation()
            
            if let route = route {
                MapPolyline(route)
                    .stroke(.red, lineWidth: 5)
            }
        }
        .lookAroundViewer(isPresented: $showLookAroundView, initialScene: lookAroundView)
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapPitchToggle()
            MapScaleView()
        }
        // shift + option = 3d view
        // shift + cmd = zoom in/out
        .mapStyle(.hybrid(elevation: .realistic))
        .onAppear {
            // improvements
            // modify this func to check user access first
            // if it's not allowed or allow once,
            // then request locaation access again
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func getLookAroundView(coordinate: CLLocationCoordinate2D) async -> MKLookAroundScene? {
        do {
            return try await MKLookAroundSceneRequest(coordinate: coordinate).scene
        } catch {
            print("Something went wrong")
            return nil
        }
    }
    
    func getUserLocation() async -> CLLocationCoordinate2D? {
        let updates = CLLocationUpdate.liveUpdates() // nil, lat+lon, nil, nil...
        
        do {
            let update = try await updates.first { $0.location?.coordinate != nil } // high-order funcs
            return update?.location?.coordinate
        } catch {
            print("Something went wrong")
            return nil
        }
    }
    
    func getDirections(destination: CLLocationCoordinate2D) {
        Task {
            guard let userLocation = await getUserLocation() else { return }
            
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: .init(coordinate: userLocation)) // initial location / user location
            request.destination = MKMapItem(placemark: .init(coordinate: destination)) // destination
            request.transportType = .walking
            
            do {
                let directions = try await MKDirections(request: request).calculate()
                route = directions.routes.first
            } catch {
                print("Something went wrong")
            }
        }
    }
}

#Preview {
    ContentView()
}
