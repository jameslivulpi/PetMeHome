//
//  MapView.swift
//  petfinder
//
//  Created by James Livulpi on 8/5/21.
//
import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    var currentLocation: CLLocationCoordinate2D?
    var withAnnotation: MKPointAnnotation?

    @State private var annotation = MKPointAnnotation()
    @EnvironmentObject var petModel: PetModel

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            if !mapView.showsUserLocation {
                parent.centerCoordinate = mapView.centerCoordinate
            }
        }

        @objc func addAnnotation(gesture: UIGestureRecognizer) {
            if gesture.state == .ended {
                if let mapView = gesture.view as? MKMapView {
                    let point = gesture.location(in: mapView)
                    let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
                    // let annotation = MKPointAnnotation()
                    // mapView.removeAnnotation(annotation)
                    parent.annotation.coordinate = coordinate
                    mapView.addAnnotation(parent.annotation)
                }
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIView(context: Context) -> MKMapView {
        let myMap = MKMapView(frame: .zero)
        myMap.isZoomEnabled = true
        let longPress = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.addAnnotation(gesture:)))
        longPress.minimumPressDuration = 1
        myMap.addGestureRecognizer(longPress)
        myMap.delegate = context.coordinator

        return myMap
    }

    func addAnnotation(for coordinate: CLLocationCoordinate2D) {
        let newAnnotation = MKPointAnnotation()
        newAnnotation.coordinate = coordinate
        annotation = newAnnotation
    }

    func updateUIView(_ uiView: MKMapView, context _: Context) {
        uiView.showsUserLocation = true
        uiView.isScrollEnabled = true
        uiView.isZoomEnabled = true
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: currentLocation!, span: span)

        uiView.setRegion(region, animated: true)
    }
}

struct AnyMapAnnotationProtocol: MapAnnotationProtocol {
    let _annotationData: _MapAnnotationData
    let value: Any

    init<WrappedType: MapAnnotationProtocol>(_ value: WrappedType) {
        self.value = value
        _annotationData = value._annotationData
    }
}
