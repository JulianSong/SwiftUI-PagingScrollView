//
//  PagingScrollView.swift
//  TestWebView
//
//  Created by songjunliang on 2023/2/22.
//

import SwiftUI

struct PagingScrollView<Content>: UIViewRepresentable where Content: View {
    var isPagingEnabled = true
    var showsHorizontalScrollIndicator = false
    var showsVerticalScrollIndicator = false
    var clipsToBounds = false
    var content: (UIScrollView) -> Content

    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = isPagingEnabled
        scrollView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
        scrollView.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        let hostingController = UIHostingController(rootView: content(scrollView))
        scrollView.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        hostingController.view.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        hostingController.view.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        hostingController.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        hostingController.view.widthAnchor.constraint(greaterThanOrEqualTo: scrollView.widthAnchor).isActive = true
        hostingController.view.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor).isActive = true
        hostingController.view.backgroundColor = .clear
        scrollView.clipsToBounds = clipsToBounds
        return scrollView
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {}
}


struct PagingScrollView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            VStack{
                GeometryReader { proxy in
                    PagingScrollView { scrollView in
                        LazyHStack(alignment: .top, spacing: 10) {
                            ForEach(1...100,id:\.self) { _ in
                                Color.pink
                                    .frame(width: proxy.size.width - 40)
                                    .cornerRadius(8)
                            }
                        }
                        .padding(.leading,20)
                    }
                    .frame(width: proxy.size.width - 30)
                }
                .padding(.vertical,20)
                .frame(height: 300)
                .background(Color.clear)
                Spacer()
            }
            Spacer()
        }
    }
}
