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
    var content: (UIScrollView) -> Content
    init(@ViewBuilder content: @escaping (UIScrollView) -> Content) {
        self.content = content
    }

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
        scrollView.clipsToBounds = false
        return scrollView
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {}
}

struct PagingScrollView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            GeometryReader { proxy in
                PagingScrollView { scrollView in
                    HStack(alignment: .top, spacing: 8){
                        Color.pink
                            .frame(width: proxy.size.width - 32)
                        Color.blue
                            .frame(width: proxy.size.width - 32)
                        Color.yellow
                            .frame(width: proxy.size.width - 32)
                    }
                    .padding(.horizontal,16)
                }
                .frame(width: proxy.size.width - 24)
            }
            .padding(.vertical,16)
            .frame(height: 200)
            Spacer()
        }
    }
}
