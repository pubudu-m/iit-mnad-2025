//
//  ContentView.swift
//  MapKitDemoFT
//
//  Created by Pubudu Mihiranga on 2025-12-12.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let cameraPosition: MapCameraPosition = .region(.init(
        center: .init(latitude: 37.3346, longitude: -122.0090),
        latitudinalMeters: 1500,
        longitudinalMeters: 1500))
    
    let appleHQ = CLLocationCoordinate2D(latitude: 37.3346, longitude: -122.0090)
    let appleParkVisitorCenter = CLLocationCoordinate2D(latitude: 37.332753, longitude: -122.005372)
    let panamaPark = CLLocationCoordinate2D(latitude: 37.347730, longitude: -122.018715)
    
    @State private var lookAroundScene: MKLookAroundScene?
    @State private var showLookAroundScene: Bool = false
    
    let locationManager = CLLocationManager()
    
    @State private var route: MKRoute?
    
    var body: some View {
        Map(initialPosition: cameraPosition) {
//            Marker("Apple Park Visitor Center", systemImage: "laptopcomputer", coordinate: appleParkVisitorCenter)
//            
//            Marker("Panama Park", systemImage: "tree.fill", coordinate: panamaPark)
            
            Annotation("Apple Park Visitor Center", coordinate: appleParkVisitorCenter, anchor: .bottom) {
                Image(systemName: "laptopcomputer")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.white)
                    .frame(width: 20, height: 20)
                    .padding(7)
                    .background(.pink.gradient, in: .circle)
                    .contextMenu {
                        Button("Open look around view", systemImage: "binoculars") {
                            Task {
                                lookAroundScene = await getLookAroundScene(coordinate: appleParkVisitorCenter)
                                if lookAroundScene != nil {
                                    showLookAroundScene = true
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
                    .background(.green.gradient, in: .circle)
                    .contextMenu {
                        Button("Open look around view", systemImage: "binoculars") {
                            Task {
                                lookAroundScene = await getLookAroundScene(coordinate: panamaPark)
                                if lookAroundScene != nil {
                                    showLookAroundScene = true
                                }
                            }
                        }
                        
                        Button("Get directions", systemImage: "arrow.turn.down.right") {
                            getDirections(destination: panamaPark)
                        }
                    }
            }
            
            UserAnnotation()
            
            // if let route = route
            if let route {
                MapPolyline(route)
                    .stroke(.red, lineWidth: 5)
            }
        }
        .lookAroundViewer(isPresented: $showLookAroundScene, initialScene: lookAroundScene)
        .onAppear {
            // can improve more: https://medium.com/@desilio/getting-user-location-with-swiftui-1f79d23c2321
            locationManager.requestWhenInUseAuthorization()
        }
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapPitchToggle()
            MapScaleView()
        }
        .mapStyle(.imagery)
    }
    
    func getLookAroundScene(coordinate: CLLocationCoordinate2D) async -> MKLookAroundScene? {
        do {
            return try await MKLookAroundSceneRequest(coordinate: coordinate).scene
        } catch {
            return nil
        }
    }
    
    func getDirections(destination: CLLocationCoordinate2D) {
        Task {
            guard let userLocation = await getUserLocation() else { return }
            
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: .init(coordinate: userLocation))
            request.destination = MKMapItem(placemark: .init(coordinate: destination))
            request.transportType = .walking
            
            do {
                let directions = try await MKDirections(request: request).calculate()
                route = directions.routes.first
            } catch {
                print("Error getting the route")
            }
        }
    }
    
    func getUserLocation() async -> CLLocationCoordinate2D? {
        let updates = CLLocationUpdate.liveUpdates()
        
        do {
            let update = try await updates.first { $0.location?.coordinate != nil }
            return update?.location?.coordinate
        } catch {
            return nil
        }
    }
}

#Preview {
    ContentView()
}
