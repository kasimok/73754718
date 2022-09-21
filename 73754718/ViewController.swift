import Cocoa


// Mark: Copy

class CopyView: NSView,NSDraggingSource{
    
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        //self.view
        self.layer?.backgroundColor = NSColor.lightGray.cgColor
        self.layer?.borderWidth = 2
        self.layer?.borderColor = NSColor.systemBlue.cgColor
        
    }
    
    func draggingSession(_ session: NSDraggingSession, sourceOperationMaskFor context: NSDraggingContext) -> NSDragOperation {
        return .copy
    }
   
}


extension CopyView: NSPasteboardItemDataProvider{
    func pasteboard(_ pasteboard: NSPasteboard?, item: NSPasteboardItem, provideDataForType type: NSPasteboard.PasteboardType) {
        
        debugPrint("provideDataForType!")
        // If the desired data type is fileURL, you load an file inside the bundle.
        if let pasteboard = pasteboard, type == NSPasteboard.PasteboardType.fileURL, let fileUrl = Bundle.main.url(forResource: "helloworld", withExtension: "txt") {
            pasteboard.setData(fileUrl.dataRepresentation, forType:type)
        }
    }
    
    override func mouseDown(with theEvent: NSEvent) {
        //1. Creates an NSPasteboardItem and sets this class as its data provider. A NSPasteboardItem is the box that carries the info about the item being dragged. The NSPasteboardItemDataProvider provides data upon request. In this case a file url
        let pasteboardItem = NSPasteboardItem()
        pasteboardItem.setDataProvider(self, forTypes: [NSPasteboard.PasteboardType.fileURL])
        
        //2. Creates a NSDraggingItem and assigns the pasteboard item to it
        let draggingItem = NSDraggingItem(pasteboardWriter: pasteboardItem)
        draggingItem.setDraggingFrame(self.bounds, contents: NSImage(named: "Preview")) // `contents` is the preview image when dragging happens.

        
        //3. Starts the dragging session. Here you trigger the dragging image to start following your mouse until you drop it.
        beginDraggingSession(with: [draggingItem], event: theEvent, source: self)
    }
}










// Mark: Move



class MoveView: NSView,NSDraggingSource{
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        //self.view
        self.layer?.backgroundColor = NSColor.lightGray.cgColor
        self.layer?.borderWidth = 2
        self.layer?.borderColor = NSColor.systemRed.cgColor
        
    }
    
    func draggingSession(_ session: NSDraggingSession, sourceOperationMaskFor context: NSDraggingContext) -> NSDragOperation {
        return .move
    }
}


extension MoveView: NSPasteboardItemDataProvider{
    func pasteboard(_ pasteboard: NSPasteboard?, item: NSPasteboardItem, provideDataForType type: NSPasteboard.PasteboardType) {
        
        debugPrint("provideDataForType!")
        // If the desired data type is fileURL, you load an file inside the bundle.
        if let pasteboard = pasteboard, type == NSPasteboard.PasteboardType.fileURL, let fileUrl = Bundle.main.url(forResource: "helloworld", withExtension: "txt") {
            pasteboard.setData(fileUrl.dataRepresentation, forType:type)
        }
    }
    
    override func mouseDown(with theEvent: NSEvent) {
        //1. Creates an NSPasteboardItem and sets this class as its data provider. A NSPasteboardItem is the box that carries the info about the item being dragged. The NSPasteboardItemDataProvider provides data upon request. In this case a file url
        let pasteboardItem = NSPasteboardItem()
        pasteboardItem.setDataProvider(self, forTypes: [NSPasteboard.PasteboardType.fileURL])
        
        //2. Creates a NSDraggingItem and assigns the pasteboard item to it
        let draggingItem = NSDraggingItem(pasteboardWriter: pasteboardItem)
        draggingItem.setDraggingFrame(self.bounds, contents: NSImage(named: "Preview")) // `contents` is the preview image when dragging happens.
                                      
        
        //3. Starts the dragging session. Here you trigger the dragging image to start following your mouse until you drop it.
        beginDraggingSession(with: [draggingItem], event: theEvent, source: self)
    }
}

class ViewController: NSViewController {
    
    @IBOutlet weak var copyView: CopyView!
    
    @IBOutlet weak var moveView: MoveView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

